# Using CSV instead of a Database

I thought about this for a while. In industry standards, for the kind of data we are dealing with when talking about restaurants, using a database would be a far better approach than using a CSV file. I say that thinking about relationships between restaurant and cuisine(which already exist), data realiability when registering a new restaurant/cuisine, scalability when thinking about adding other entities(like user, for example), etc. Overall, I think it would be a better approach.

Having said that, I decided against using a database because of this phrase in the exercise README: ```Since this assessment includes a searching function, we kindly ask you to avoid out of box search engines such as ElasticSearch. Instead, you should write the searching logic by yourself.```. Although it isn't as robust as a search engine like ElasticSearch, databases(and ActiveRecord in ruby) provide a lot of useful tools when making a query. Many of the search pre-requisites(like getting a distance equal or below the given one) could be made with a simple line of query in the database. For that reason, I decided to use the data in the csv file directly in this exercise, to better illustrate how I would handle data.

# Optional Params

When I was making the exercise, I thought about how I search for food in apps. It came to my mind that I often search by two things: name or cuisine, one or the other. If I have a restaurant in mind, I usually search for it's name. It I want to eat japanese food, for example, I search the keyword ```japanese```. For that reason, I allowed the user to pass only of one these twos, and the rest could be optional. Of course, the user can also give every parameter, but this approach makes the following parameters as optional:

- Distance;
- Price;
- Customer Rating.

# Writing Services responsible for one action only

I decided to write services that are responsible for one action for a couple reasons, some of them being:

- It makes it easier for testing, since each file is responsible for one thing only;
- Refactoring is simpler, since every file is independent;
- Files are smaller, making them easier to read and understand the code.