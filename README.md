## Requirements
- ruby 3.1.0
- rails 7.0.2

## How to use
1. Install ruby using rvm `https://rvm.io/rvm/install`
2. Then, install specific ruby version, example:  
    ```bash 
    rvm install 3.1.0
    ```
3. Use as global version on your shell ```rvm use 3.1.0```
4. Bundle install this project
5. Put ``` .env``` file on main project
6. Run command create database & run migration, seed files
    ```bash
    rails db:create 
    ```
    ```bash
    rails db:migrate
    ```
    ```bash
    rails db:seed
    ```
7. Finally, import file ```Atask Test.postman_collection.json``` collection postman into postman app.