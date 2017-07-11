# Project rationale
This project has been started to replace a previous one (Project FreshFeel). The purpose of this document is to justify this choice in a committee meeting setting.

My opinions on the matter were heavily endorsed by Teddy Reiss (former techteam collaborator).

Reasons include:
1. The previous project had a lot of code that I deemed difficult to maintain and to understand.
2. I deemed the way the domain model had been implemented lacking in several respects
3. The implementation of a variety of features, some of which explictly requested by the committee, would have been facilitated by a brand-new project, with those features in mind. This includes a graphic redesign.

## 1. Maintainability
The new code base I've worked on is heavily documented. The workflow has been accurately explained and streamlined. Best practices have been defined. This should allow for a smooth transition between webmasters.

Furthermore, various unused features have been removed. An effort has been made to make the code base agile and to set the ground work for possible future features.

Attention has been put into automated testing, to make sure the website's basic functionalities keep working between releases.

## 2. Domain model restructuring
### Scheduling
The main deficiency of the previous project regarded schedule management. The new system:
- adds shows to schedules instead of broadcast times to shows
- uses a multi-schedule approach
This makes creating and keeping schedules up to date way more convenient.

Also, now the system allows 'free' transitional schedules to be handled by the website. This makes it possible to show broadcast times of shows to users, even on booking-based schedules. It also provides a consistent and effective way of handling bookings, independent of external resources, like Google Docs spreadsheets

Even though the new website makes accurate schedules more likely, it is less rigidly reliant on them (some inaccuracies may be caused by several factors, like one show covering for another). Thus, for example, it allows to upload podcasts for arbitrary dates, and for broadcast information it relies on metadata fetched from megatron.

### Accounts
The new authentication and authorization system
- Makes it easier to obtain user accounts. This can be done by users themselves
via the 'Sign up' function, instead of having to contact the webmaster and giving
him the relevant information
- Is more secure, since it automatically logs out users after a fixed time
- Has a more fine-grained permission management system, thus granting users access to
exactly what they need to access.

## 3. New features
### Redesign
Rewriting the back-end has allowed for a full redesign, aimed at making the
website better and more professional looking. More content has been added to
the homepage. For example, the left sidebar now displays a list of upcoming
events organized by the station and information and a link about the current
show on air.

### Posts
Posts now are easier to format, through a WYSIWIG editor replacing the previous
markdown parser. Pictures can now be embedded inline, instead of just being
added to a gallery.
Now hosts can write posts and add them to their show pages.

### Communication with Broadcast Controls
It is now possible to send messages from the website to the studio.
It's also possible to set from the studio the 'current broadcast information'
displayed on the website.
Schedules on the website compare information Megatron holds about shows gone
on-air and generates reports for the Head of Programming.

### Podcasts
Now hosts can add a list of played tracks to podcasts.



*Leonardo Mazzone, July 2017*
