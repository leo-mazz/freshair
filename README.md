# README
This is the old repo of the website for FreshAir.org.uk, Edinburgh’s student radio station. This project has been forked and is now maintained by FreshAir's web team.

## Credits
This website was originally built by [Leonardo Mazzone](https://mazzone.space).

## Quick Start
### Requirements
To run this application, you will need Ruby 2 and Rails 5.
You will also need ImageMagick to make the gem 'MiniMagick' work.
For comprehensive instructions on how to install these on your system, please
check their respective documentations.

### Build
To install all dependencies
`bundle install`
Do NOT `sudo` the command above.

You can launch a development server with
`rails server`

You can launch an interactive Rails console with
`rails c`

In production, you should prefix the above two commands with
`RAILS_ENV=production`

You can create a first admin user through the console. You want to skip email confirmation and
registration approval.
```
user = User.new(email: 'jsmith@example.com', first_name: 'John', last_name: 'Smith', :password => 'safe_password', :password_confirmation => 'safe_password', approved: true)

user.skip_confirmation!

user.add_role :admin

user.save
```

For bug-fixing, during development, you can place the following line
`byebug`
anywhere in your code. Execution will stop there and you will get a console.

### Deployment
Deployment is done through Capistrano. After committing and pushing changes to
the remote repository, simply run

`bundle exec cap production deploy`

Since we need to use the server 'Tardis Fez' as a bastion host to our Virtual
Machine, you will need to login with a user on Tardis. To request one, get in
touch with the Tardis guys, they are sweet and meet weekly. For more info, check
their [wiki](http://tardis.ed.ac.uk).

After deploying changes with Capistrano, at the moment, you will need to
restart apache on the Virtual Machine, with
`sudo service apache2 restart`

### Testing
Run tests with `rails test`

You **should not** deploy if some test fails.

People working on this project are expected to be volunteers and busy students,
thus, writing a complete test suite is unfeasible (even though that's the goal
to aspire to).

You **should**, on the other hand, write unit tests for code sections that use
complicated logic or if you're a little bit hazy on what you want to implement
(please, in the best spirit of
[TDD](https://en.wikipedia.org/wiki/Test-driven_development), write your tests
first). You should also write integration tests for crucial workflows.

Instead of standard Rails fixtures, we use [FactoryGirl](https://github.com/thoughtbot/factory_girl). They are defined in
`test/factories.rb`

More info [here](http://guides.rubyonrails.org/testing.html)

## Extended documentation
### Philosophy
- The website should strive for graphical consistency and be pleasing to the eye.
- It should be as flexible as possible to the needs of different users and
seamlessly adapt according to the lack or presence of user-generated content.
- The administrative side should be a pleasure to use and encourage virtuous
practices.
- The website should generate compliant, semantic, and accessible HTML5
- The website should be mobile-ready
- The website should allow mind-blowingly fast deployment for easy bug-fixing
and features development, on new servers as well.
- The website should be secure. Precautions should be taken against all kinds of
security threats. Secrets should not be in the repository.
- Modularity is key. The website should not have responsibilities beyond its
scope and domain. Interaction with other modules (like the Broadcast Controls)
should happen through the API.
- The website should require minimal maintenance from the webmaster.
- The code should be well-tested.
Views and stylesheets should also be tested manually and on different
browsers and devices.
- The code should be heavily documented, both with comments in the code itself
and as external documentation (like this README file). The documentation should
always be up to date. This allows for effective hand-overs between webmasters.
Clear and extensive documentation should also be offered to all users.

### Where to put your code
Ruby on Rails follows the
[MVC pattern](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller).
Consequently, code in `app/views` should only include presentational code, and
as little logic as possible. To make views slimmer, we can use helpers in
`app/helpers`. Helpers should be used as means of formatting content, or as
simple reusable UI components. All the logic related to the
[Domain Model](https://en.wikipedia.org/wiki/Domain_model) should be put in
`app/models`. Code in `app/controllers` should only serve as an interface
between views and models and should be as skinny as possible.
You can write custom validators to validate resources before they are saved and
put them in `app/validators`. If you need to write logic that uses external
services or APIs, please put that in `app/services`. Services could also be used
for more creative purposes, for more information take a look
[here](http://stevelorek.com/service-objects.html).

### Slugs
Several entities (such as shows, posts and tags) will be referenced by slug
instead of by id. Slugs are automatically generated with help from the gem
'FriendlyId'. They are also updated when the title of the entity changes.
This means that, for example, changing the title of a post might break a
previously functioning URL.

### Sanitized HTML
Various fields (like the description of events, and the content of posts) contain
HTML. This needs to be marked as safe to be rendered (through rails method
'html_safe') and,in order to avoid security threats, sanitized (through the rails
method 'sanitize'). There is a list of acceptable tags and attributes that won't
filtered in the helper 'ContentHelper'. In admin views we just use the default
accepted tags and attributes instead.

### Models
#### Shows
Shows are deemed to be 'active' if they are assigned to the current schedule.
They can be assigned to the current schedule multiple times (i.e. they can occur
more than once a week or at multiple times). Currently though, only the first
broadcast time will be displayed on the show pages. This might be changed in the
future. Shows that are 'hub shows' (assigned to a team) won't let assigning users
through the admin panel.

#### Schedules
Schedules record 'assignments', which include a day of the week, a start time,
an end time and a show.
Before a schedule is saved, its assignments are validated for consistency: time
clashes are not allowed.
If the current schedule will expire in a period of 10 days, users are notified
on the 'Schedule' page.
A schedule can be marked as *free schedule*, meaning that users will be able to
book the Main Studio. Free schedules are meant as temporary schedules in
transitory periods (e.g. the end of the semester). You can still add standard
assignments to a free schedule. Additional checks are performed on schedules and
bookings to prevent clashes.
The website will consider a schedule to be current on the basis of the start
date and end date fields. They can either be both empty (to make draft
schedules) or both be full. The website makes the current schedule and the most
imminent future schedule accessible by users.

#### Events
If upcoming events are present, they will be displayed in the sidebar. They're
considered 'upcoming' on the basis of their start date.

#### Pages and sub-pages
Pages are automatically displayed in the main navigation menu. They have stricter
permission rules. They have sub-pages associated to them.
Sub-pages have to be assigned to a parent page and will be accessible from it.

#### Podcasts
Podcasts will need a valid MixCloud URL (the proper embed content will be
generated by the helper UriHelper) and a broadcast date.
Podcasts can be assigned played tracks.
Some teams have a 'Hub show'. If there's one, the latest podcast of a show that
is the hub show for some team, will be displayed on that team's page.

#### Posts
Posts have a short body that will be displayed in the index view. If no body is
present, one will be extracted from the content of the post. Posts will only be
displayed if their attribute 'is_published' is set to true, thus allowing for
drafts.
Posts can be assigned metadata, which will be displayed in various ways in the
post details sidebar. An example is for ratings in reviews: the score will be
displayed as stars. Posts can be assigned tags.
Posts can be assigned a team and a show. If this is done, they will appear
on the associated team or show page.

#### Tags
If tags are marked as 'post type', you will be able to filter posts using that
tag from the home page.

#### Teams
Each team will have its page, with a personalized body, displayed at the top,
a list of the latest posts associated to the team and, for each of the latest
tags used by that team, the latest posts under that tag associated to that team.
If the team has a 'hub show' and the 'hub show' has a latest podcast, that will
be displayed right below the navigation.

#### Users
Users can sign up to request a user account and specify which roles they want
to be assigned. They need to confirm their email and also be approved by an
admin. Before approving them, their roles should be carefully checked. In case
of doubt, check with the Committee. Users can edit, but not destroy their
accounts. Please note that if you destroy a user account, you risk creating
orphans (and breaking many things). So maybe don't.

#### Settings
Settings can be used by a system administrator to tweak the behavior of the
website. Right now, the setting 'home-header' will allow inserting sanitized
HTML on the homepage, after the navigation, and the setting
'fringe-twitter-feed' will display the FreshFringe feed instead of the standard
one when set to 'true'. The website is supposed to work out of the box with
no settings.


### Gems
This project depends on a range of gems. Their purpose is described in the
Gemfile. For more details about usage, please refer to their individual
documentations.


### Player
#### Broadcast information
The player uses AJAX to update its information, fetched from the server 'Megatron'.
There are two reasons these are not being fetched from the current schedule:
1. Often shows swap times or cover for other shows.
2. A current schedule might not have been set or might have mistakes due to
the negligence of the Head of Programming.

In both cases we want the current broadcast information to be as accurate as
possible, regardless of the current schedule on the website.

There is an additional reason: we want Megatron to have, potentially, the
freedom to stream something else than a show the website knows about.


#### Standalone player
There is a standalone player accessible on the route `/listen`. This can for
example be embedded on the official Facebook page. It should not be used in
cases where only a stream of audio is needed. For that, simply use
https://studio.freshair.org.uk:8443/radio.

#### Instructions
The file `doc/instructions.md` is meant as a simple but comprehensive guide
on FreshAir IT. Please, keep it up to date. It will be parsed and served to
users at the endpoint `/help`.

### Sending emails
The website uses email through SMTP using its domain provider (currently
NameCheap). It will need outbound access to port 587.

### Roles
Each user can have roles assigned to it. Roles are managed with the help of the
gem 'rolify'. When signing up, users can request to be assigned any role but the
admin one. The admin user should accurately review their roles before approving
them. All roles are defined in the helper `RolesHelper`. User permissions are
managed with the help of the gem 'cancancan' and described in the file
`/model/ability.rb`. Keep in mind that some roles are implicit and not handled
through rolify. For example, one has the ability to manage a show if there is
a 'ShowMembership' entity referencing both the user and the show.

### Secrets
The application needs a few secrets to do things like generate user session ids,
authenticate to the Twitter API, or send emails through its service provider.
These secrets are contained in `config/application.yml`, not staged to the
version control system for obvious security reasons. This file contains also
some configuration variables. The application will definitely need these in
production. Ask the current webmaster if you need them.

### API
The sub-routes of `/api/` are utilities for exchanging information (in JSON)
with the server 'Megatron'.

### Known Issues
In development, when changing an Active Admin model, and loading an admin page,
we encounter an Error 500, caused by
`ArgumentError (A copy of ApplicationController has been removed from the module tree but is still active!):`
An extra refresh should fix.

If you use Ckeditor for a new field, its layout will be broken (which sucks). You'll have to use a hack: edit the file `app/assets/stylesheets/active_admin.scss` and add a new selector like the ones already there (use your browser's code inspector to find the right one).

When studio messages are submitted, the date sent is the one of the timezone of
the user sending the message. This should be fixed.

When submitting schedule assignments something really weird happens with the
timezone sometimes.
