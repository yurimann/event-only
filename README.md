
Views and Forms - Assignment
========

Rails Form Helpers
-----

Refactor the below HTML form so that it uses Rails form helpers. Assume
that `@job_application` is an empty `JobApplication` object.

@TODO Link to Rails form docs

```html
<form class="new_job_application" id="new_job_application" action="/job_applications" accept-charset="UTF-8" method="post">
  <p>
    <label for="job_application_full_name">Full name</label>
    <input type="text" name="job_application[full_name]" id="job_application_full_name" />
  </p>

  <p>
    <label for="job_application_phone">Phone</label>
    <input type="tel" name="job_application[phone]" id="job_application_phone" />
  </p>

  <p>
    <label for="job_application_hobby">Hobby</label>
    <input type="text" name="job_application[hobby]" id="job_application_hobby" />
  </p>

  <p>
    <label for="job_application_years_experience">Years experience</label>
    <input type="number" name="job_application[years_experience]" id="job_application_years_experience" />
  </p>

  <p>
    <label for="job_application_available_date">Available date</label>
    <input type="date" name="job_application[available_date]" id="job_application_available_date" />
  </p>

  <p>
    <input type="submit" name="commit" value="Create Job application" />
  </p>
</form>
```

Building Views and Forms
-----
Let's use this knowledge to build out the views and forms for an application.
Clone this repository and run:

* `rake db:migrate`
* `rake db:seed`

EventOnly is an app for creating and tracking events in different locations across Canada. There are two models:

* Location
* Event

Each of these models has a set of CRUD (Create, Read, Update, Delete) database operations. Your task will be to build the views and forms to make EventOnly a functional application!

The database already has some locations and events in it since you ran `rake db:seed`. Let's create an index page to view them. Do this by modifying the `views/locations/index.html.erb` file.

```html
<h1>EventOnly</h1>

<%= @locations.each do |location| %>
  <div class="location">
    <h3>City: <%= location.city %></h3>
    <%= location.description %><br />
    <%= link_to image_tag(location.image, class: "location"), location %>
  </div>
<% end %>
```

Here we're iterating over our locations and displaying some information about each one, including an image.

Now navigate to `http://localhost:3000/locations` to view the locations! Note that clicking an image will take you to an empty page. That's our next step.

Let's create a page that shows off a specific location. Edit the `views/locations/show.html.erb` file as follows:

```html
<h1><%= @location.name %></h1>
<%= link_to 'Edit', edit_location_path %> |
<%= link_to 'Delete', location_path, method: :delete, data: {confirm: "Are you sure you want to delete the location '#{@location.name}'? This cannot be undone!"} %>

<div class="location">
  <h3>City: <%= @location.city %></h3>
  <%= @location.description %><br />
  <%= link_to image_tag(@location.image, class: "location"), location %>
</div>
```

Clicking an image on the index page should now take you to the show page for a specific location.

You might have noticed that we wrote code that was almost identical in both files (everything inside of the `<div>` tag). This should always be a sign that you should find a way to re-factor your code such that the duplicated code is kept in one place.

The code we duplicated had one job in both places: to display a location. Therefore, let's create a new view: `views/locations/_location.html.erb`.

```html
<div class="location">
  <h3>City: <%= location.city %></h3>
  <%= location.description %><br />
  <%= link_to image_tag(location.image, class: "location"), location %>
</div>
```

The entire purpose of this view is to render a piece of a webpage, and to do so potentially many times. For this reason it is called a [partial](http://guides.rubyonrails.org/layouts_and_rendering.html#using-partials) view. We indicate this by having an_at the start of the file name (`\_location.html.erb`).

Also notice that, in our partial, `location` is a local variable, not an instance variable. This is because the partial's job is to render whatever we give it, and we won't always have an instance variable called `@location`. To see why, look again at our code for `index.html.erb` and notice that, because we are iterating over `@locations`, we are using a local variable called `location`. We will now `render` this partial, and pass it the local variable `location`.

Let's edit `views/locations/index.html.erb` now:

```html
<h1>EventOnly</h1>

<p>
  <%= link_to 'New Location', new_location_path %>
</p>

<% @locations.each do |location| %>
  <%= render 'location', location: location %>
<% end %>
```

And edit `views/locations/show.html.erb`:

```html
<h1><%= @location.name %></h1>
<%= link_to 'Edit', edit_location_path %> |
<%= link_to 'Delete', location_path, method: :delete, data: {confirm: "Are you sure you want to delete the location '#{@location.name}'? This cannot be undone!"} %>

<%= render 'location', location: @location %>
```

Both files are now much shorter because we're using our `\_location` partial to do the actual work of deciding how a location object should look on our web page. Now we can use this code to render a location anywhere!

Let's take a closer look at the syntax for rendering a partial. `render` is a method that takes arguments. The first argument is the name of the partial we want to render, leaving out the leading underscore. That is:

`<%= render 'location' %>` or `<%= render('location') %>`

But this code is not sufficient to give the partial the location object that it needs. We therefore pass in the location object, whatever its name happens to be. We are using the name `location` in the partial, so we had better give it the same name when passing it. This is the left-hand side (the key) of the hash we are passing. The right-hand side (the value) is the location object itself. That is, in the `show.html.erb` file:

`<%= render 'location', location: @location %>`

Visit both pages again in the browser to make sure that they are still working as before.

This works wonderfully, but we can still do better. Rails is smart and knows that if we call `render` and pass it a `Location` object, we want it to render the `\_location` partial. Moreover, it knows that our variable in the partial is supposed to be named `location`. We can now edit the `show` page again:

```html
<h1><%= @location.name %></h1>
<%= link_to 'Edit', edit_location_path %> | <%= link_to 'Delete', location_path, method: :delete, data: {confirm: "Are you sure you want to delete the location '#{@location.name}'? This cannot be undone!"} %>

<%= render @location %>
```

Rails also knows that if we ask it to render a collection of Location objects, it should iterate over that collection and call render on each object. Therefore, We can now also edit the `index` page again as well:

```html
<h1>EventOnly</h1>

<p>
  <%= link_to 'New Location', new_location_path %>
</p>

<%= render @locations %>
```

Visit both pages again in the browser and you should see exactly the same output as before. Commit your changes!


### Plan (notes):

* create CRUD views for locations
* create CRUD views for events


#### Locations

1. index
  * write a view
1. show
  * need the previous view in two places! Use a partial!
1. new
  * add new link to index page
  * write a form
1. edit
  * need the previous form in two places! Use a partial form!
1. clean up/finish
  * add a Delete link to the show page




#### Events

1. show
  * write a view
1. locations show page
  * need the previous view in two places! Use a partial!
1. new
  * write a form
1. edit
  * need the previous form in two places! Use a partial form!


@TODO Search page that uses form_tag


#### Home page

1. add an index page
  * display all `@locations` and all `@events`






The End
