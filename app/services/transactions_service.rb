class TransactionsService

  def initialize(params = nil)
    @params = params
    @range_for_type = 0
    @range_for_date = 1..8
    @range_for_value = 9..18
    @range_for_document = 19..29
    @range_for_card_number = 30..41
    @range_for_date_time = 42..47
    @range_for_shopkeeper = 48..61
    @range_for_store = 62..80
    @format_files = ['txt']
  end

  def list
    search_transactions
  end

  def create_transactions
    if validate_params
      bulk_import
    end
  end

  def store_names
    @store_names ||= Store.all.map{|x| x.name}.uniq
    @store_names = @store_names.insert(0, 'Selecione uma Loja') if params[:store_name].blank?
    @store_names.delete("#{params[:store_name]}") unless params[:store_name].blank?
    @store_names
  end



  private

  def search_transactions
    @transactions ||= Transaction.
        search_by_store(params[:store_name]).
        search_by_cpf(params[:document_number]).
        order(created_at: :desc)
  end

  def validate_params
    raise ArgumentError.new("nil file error") if params.blank?
    raise ArgumentError.new("nil file error") if params[:transaction].blank?
    raise ArgumentError.new("nil file error") if params[:transaction][:file].blank?
    unless format_files.include?(params[:transaction][:file].original_filename.partition('.').last)
      raise ArgumentError.new("file format error, supported files are: #{format_files}")
    end
    true
  end

  def bulk_import
    @transactions = Transaction.import(parse_file, on_duplicate_key_ignore: { conflict_target: [
        :transaction_type,
        :value,
        :occurrence,
        :card_number,
        :document_number,
        :store_id
    ] })
    if @transactions&.ids.blank?
      false
    else
      true
    end
  end

  def parse_file
    transactions_array = params[:transaction][:file].read.each_line.to_a.reject(&:blank?)
    find_or_create_shopkeepers(transactions_array)
    find_or_create_stores(transactions_array)
    find_or_create_transactions(transactions_array)
  end

  def find_or_create_shopkeepers(transactions_array)
    shopkeeper_names = transactions_array.map{ |x| x[range_for_shopkeeper]&.force_encoding('utf-8').strip.upcase }.uniq.reject(&:blank?)
    existing_shopkeepers = Shopkeeper.where(name: shopkeeper_names).pluck(:name)
    shopkeeper_names = shopkeeper_names - existing_shopkeepers
    unless shopkeeper_names.blank?
      shopkeeper_hash = shopkeeper_names.map do |name|
        {
            name: name
        }
      end
      Shopkeeper.import(shopkeeper_hash)
    end
  end

  def find_or_create_stores(transactions_array)
    shopkeepers_hash = Shopkeeper.all.map{ |shopkeeper| { id: shopkeeper.id, name: shopkeeper.name } }
    stores_array = transactions_array.map do |line|
      [
          line[range_for_store]&.force_encoding('utf-8').strip.upcase,
          line[range_for_shopkeeper]&.force_encoding('utf-8').strip.upcase
      ]
    end.uniq.reject(&:blank?)
    stores_array.map do |store|
      Store.find_or_create_by(
          name: store.first,
          shopkeeper_id: shopkeepers_hash.detect{ |shopkeeper|
            shopkeeper[:name].parameterize == store.second.to_s.parameterize
          }[:id]
      )
    end
  end

  def find_or_create_transactions(transactions_array)
    stores_hash = Store.all.map{ |store| { id: store.id, name: store.name } }
    transactions_hash = transactions_array.map do |line|
      {
          transaction_type: Transaction.transaction_types.key(line[range_for_type].to_i),
          occurrence: "#{line[range_for_date]}#{line[range_for_date_time]}".to_datetime.in_time_zone(Time.zone),
          value: (line[range_for_value].to_d/100).to_d,
          document_number: line[range_for_document],
          card_number: line[range_for_card_number],
          store_id: stores_hash.detect do |store|
            store[:name].parameterize == line[range_for_store].force_encoding('utf-8').strip.parameterize
          end[:id]
      }
    end
    transactions_hash.uniq.reject(&:blank?)
  end

  attr_accessor :params,
                :range_for_type,
                :range_for_date,
                :range_for_value,
                :range_for_document,
                :range_for_card_number,
                :range_for_date_time,
                :range_for_shopkeeper,
                :range_for_store,
                :format_files

end