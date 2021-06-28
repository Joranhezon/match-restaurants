# Some Use Cases

### Standard:

```GetRestaurantTemplateService.new.call(name: 'icious')```

### Only Cuisine:
```GetRestaurantTemplateService.new.call(cuisine: 'japa')```

### Specifying everything:
```GetRestaurantTemplateService.new.call(name: 'icious', customer_rating: 2, distance: 20, price: 50, cuisine: 'japanese')```

### No restaurants found:
```GetRestaurantTemplateService.new.call(name: 'does not exist')```

### Neither Name nor Cuisine are passed:
```GetRestaurantTemplateService.new.call(price: 10)```

### Pass argument with type different than expected:
```GetRestaurantTemplateService.new.call(name: 10)```
```GetRestaurantTemplateService.new.call(cuisine: 10)```
```GetRestaurantTemplateService.new.call(name: 'name', price: 'a string')```
```GetRestaurantTemplateService.new.call(name: 'name', distance: 'a string')```
```GetRestaurantTemplateService.new.call(name: 'name', customer_rating: 'a string')```