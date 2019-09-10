## BoatSeeker

If you ever look for a way to be able to manage your boat fleet in a simple and straightforward API, the BoatSeeker API is for you.
With this simple app you can not only create and delete, but also visualize, and list with search features!

Despite the simplicity of the api, I fell the need to write some documentation as you will find out below.
Also, I deployed this app on Heroku. The examples in the documentation are pointing to the project there.

### Create

`POST /boats/`

- The endpoint the allows you to create a new boat, if valid.
- model, length, latitude, and longitude are mandatory.

example:
`curl -X POST \ 'https://boat-seeker.herokuapp.com/boats?model=Boat&length=15&longitude=102.2210023&latitude=42.3120905'`

### Show

`GET /boats/:id`

- The endpoint that allows you to see your boat (see its parameters, not with an actual image. Sorry!)

example:
`curl -X GET 'https://boat-seeker.herokuapp.com/boats/2'`

### Destroy

`DELETE /boats/:id`

- Use with care. This endpoint is known for delete the boat register in the database. (as expected)

example:
`curl -X DELETE 'https://boat-seeker.herokuapp.com/boats/2'`

### Index

`GET /boats` - This endpoint brings to you a list with all your boats registered in the api. - You can search for model and location

    example:
    ```curl -X GET \

'https://boat-seeker.herokuapp.com/boats?model=Boat&longitude=102.2210023&latitude=42.3120905&radius=1000' \
 -H 'Content-Type: application/json'```
