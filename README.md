# README
This is the website for FreshAir.org.uk, Edinburgh’s student radio station.

## Credits
This website was originally built by [Leonardo Mazzone](http://leomazzone.me),
with inspiration from a previous project (Project FreshFeel) by
[Hayden Ball](http://haydenball.me.uk).

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


## Extended documentation
The website is relatively simple. It allows post publishing and highlighting, it
keeps track of shows, schedules, events and playlists. It allows editing static
pages and sub-pages. It has dynamic pages for teams. It has a player for
live streaming that relies on the server 'Megatron' for both audio and metadata.

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
- The code should be well-tested. Try to write tests first before implementing
a new feature. Views and stylesheets should be tested manually and on different
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

### Models
#### Shows
Shows are deemed to be 'active' if they are assigned to the current schedule.
They can be assigned to the current schedule multiple times (i.e. they can occur
more than once a week or at multiple times). Currently though, only the first
broadcast time will be displayed on the show pages. This might be changed in the
future.

#### Schedules
Schedules record 'assignments', which include a day of the week, a start time,
an end time and a show.
Before a schedule is saved, its assignments are validated for consistency: time
clashes are not allowed.
A schedule can be set to be 'current'. There can only be one current schedule.
Schedules have a mandatory end_date field: after the end_date expires a current
schedule is automatically set to non-current. This is meant to encourage Heads
of Programming to keep an up-to-date current schedule.
If another schedule is assigned to the expired one, in the field 'next_schedule',
and it is valid (i.e. it wouldn't immediately expire as well), it will
automatically be set as 'current' and replace the previous one.
If the current schedule will expire in a period of 10 days, users are notified
on the 'Schedule' page, and if a 'next schedule' is present and valid they will
be allowed to check it out.

#### Events
If upcoming events are present, they will be displayed in the sidebar. They're
considered 'upcoming' on the basis of their start date.

#### Pages and sub-pages
Pages are automatically displayed in the main navigation menu. They can only be
modified by Admin users. They have sub-pages associated to them.
Sub-pages have to be assigned to a parent page and will be accessible from it.
The content of both pages and sub-pages is sanitized HTML (e.g. you can't use
script tags).

#### Playlists

#### Posts

#### Users
Users can sign up to request a user account and specify which roles they want
to be assigned. They need to confirm their email and also be approved by an
admin. Before approving them, their roles should be carefully checked. In case
of doubt, check with the Committee.


#### On air records
Contain a show slug, and the times it went on air and off air.

#### Broadcast reports
Contain a date, complete schedule information valid for that date (which is,
slugs of shows associated to their start time and end time) and several on air
records. There is a method that allows to check whether a broadcast report is
blatantly inconsistent with the schedule information it stores.

### Gems
This is a partial list of the gems used by this application. For information
check their respective documentations.

- **CarrierWave** for uploading files
- **MiniMagick** for image manipulation, required by CarrierWave to create
thumbnails
- **FriendlyId** for friendlier URLs. It allows to reference entities by their
slug instead of their id and automatically generates slugs
- **Capistrano** for deployment and to automate tasks on the server
- **Active Admin** for an admin interface
- **Active Admin Editor**, WYSIWYG editor for posts and pages
- **Font Awesome** for sweet inline icons
- **Twitter** helper, for the Twitter feed
- **Autolink** to automatically generate 'a' tags from links
- **Devise** for user authentication
- **Rolify** to define user roles
- **CanCanCan** to restrict resources to user with specific roles
- **Figaro** to use environment variables

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
http://studio.freshair.org.uk:8000/radio.

### OpenID
The website uses openID to authenticate users trying to access show recordings
on the server 'Megatron'.

### Sending emails
The website uses email through SMTP using its domain provider (currently
NameCheap). It will need outbound access to port 587.

### Roles
Each user can have roles assigned to it. Roles are managed with the help of the
gem 'rolify'. When signing up, users can request to be assigned any role but the
admin one. The admin user should accurately review their roles before approving
them. All roles are defined in the helper `RolesHelper`. User permissions are
managed with the help of the gem 'cancancan' and described in the file
`/model/ability.rb`.

### Secrets
The application needs a few secrets to do things like generate user session ids,
authenticate to the Twitter API, or send emails through its service provider.
These secrets are contained in `congif/application.yml`, not staged to the
version control system for obvious security reasons. The application will
definitely need these in production. Ask the current webmaster if you need them.

### API
The sub-routes of `/api/` are utilities for exchanging information (in JSON)
with the server 'Megatron'.

### Known Issues
In development, when changing an Active Admin model, and loading an admin page,
we encounter an Error 500, caused by
`ArgumentError (A copy of ApplicationController has been removed from the module tree but is still active!):`
An extra refresh should fix.
