
# test_recruitment_api

  
![enter image description here](https://i.imgur.com/YFv0MlW.png)
  

### Prerequisites

- Install Docker - [See Instalation](https://docs.docker.com/install/overview/)

- Install Docker Compose - [See instalation](https://docs.docker.com/compose/install/)

  
  
## Setup

1. `clone the project`

2. `cd /test_recruitment`

3. `cp .env.example .env`

4. `docker-compose up --build`

5. `docker-compose exec web bash`

6. `rails db:create`

7. `rails db:migrate`

8. `check` [localhost](http://localhost:3000)

9. `thats it! C:`




  

[top ⇈](#settings)

  

### Utilities

1. `troubles with permission? run: 'sudo chown -R $USER:$USER .'`

2. `optionally you can generate records with 'rails db:seed' inside bash container`

  