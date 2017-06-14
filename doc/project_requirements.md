# Refresh Project
## Discussion
### Main points
#### Broadcast
**Introduction:**  I want to implement system to allow player to know with more precision what show is on air (if any), regardless of switches and people not showing up, ignoring current schedule. I also want to notify Head of Programming of differences between current schedule and reality. I want to do so by forcing hosts to login and pick one of their show before going on air.
I want to consider finding a way of automatically cutting off a show that goes off time to make sure this system does not break.

- How much time between a show and the next? How much time is needed to change show?
- Are shows allowed to not finish in time?
- Does it happen that shows go momentarily off air?
- (current plan: no) In the chance of users being requested to indicate their identity and show before going on air, do we want to ask their password?
- Is it possible to infer how long a show is? Or sometimes same show different lengths?
- If it is, would it be ok to automatically go off air on a timer?
- Might it be interesting to record a history of played tracks? How long should it live?
- How have prerecorded shows been handled so far? How do we want to handle them in the future? Problem of location and of time scheduling.

#### Shows and scheduling
**Introduction**: I want to change the way scheduling is handled. Shows don't hold information about when they should go on air. Schedules have these information: shows can be assigned to schedules at particular times. Multiple schedules can be created on the website for convenience and the Head of Programming will be easily able to set one of them as the current one. Each schedule will have an end date to be set and after the date goes by a schedule is automatically not considered current anymore and not shown on the website with the goal of not notify annoyngly HoP and of telling the truth on the Schedule page for listeners. Successor schedules, free schedules

- (current approach: login based, compared to current schedule, generate weekly report than can be visualized and will be emailed to Head of Programming) How to best handle switches?
- How do we want to display schedules? Easiest way is Monday-Sunday but that will present inconsistencies if schedule stops being current in the middle of the week
- What are hub shows?
- What are rotating slots?
- (current approach: it's there, just, optional)Are we interested in a Tag Line?
- (current approach: yes) Should we keep track of **Shows** from the past / make them publicly accessible? Why?
- (current approach: yes) If a show is reassigned to a new schedule (like, show with the same name, possibly different hosts), is it the same object?
- What are the different types of **Shows**?
  - Differentiation by genre?
  - Differentiation by team?
  - Differentiation by made by committee member / not so?
  - Something else?
- What's up with uploading podcasts?
- (current approach: drop field) Are live shows and prerecorded shows starkly distinguished (i.e. drop field)?
- What degree of freedom do we want to give hosts to their shows page? Can go from just editing the details, to edit some formatted static content, to publish updates (like mini-posts)

#### Music and playlist
**Introduction**: I want to improve integration of playlists into website
- How has the playlist been handled so far?
- I want to integrate that with the website. How could that work? Embed from what services?
- Are you interested in multiple playlists?
- How important is the weekly playlist from music team for the station? Do we want to display it in the sidebar?

#### Posts and dynamic pages
**Introduction**:  I'm going to remodel the way posts work to make them free from team restrictions (allow shows to post updates), better style the content (for example according to the type of post, e.g. reviews), easier to edit, allow to highlight them.
I will  assign a dynamic page per team and they will have freedom in what the content on it should be.

- What do we want posts to be?
- (current approach: no) Closely related to above: Does a rigid division of **Posts** by **Team** still make sense? RIght now only people in teams are allowed to publish.
- What's media team?
- I will introduce a dynamic page for each team and discuss with the heads what they want on them. Simplest case: just posts written by members of that team and recent tags
- What requirements do posts have? What kind of content is posted?
  - (Formatted) text? Images (in what format should they be attached)? Attachments? Embeds (and what kind)? Something else?
  - As for pictures, is it an important requirement to display them inline? Because it would be way easier for me to put them in a gallery section (with captions) at the end of the post, unless they come from an external source.
  - Same as above for embeds
- (current approach: wysiwyg is better than markdown) What kind of editor would you prefer?
- Given the possibility of filtering **Posts**, how should they be displayed by default on the homepage?
  - (ca: yes)Chronological order?
  - Division by type
    - Examples: event, playlists, reviews
  - (current approach: yes) Might it be interesting to highlight specific **Posts** on the homepage?
  - (current approach: yes, and they can be highlighted) Might it be interesting to have temporary tags for particular events?
    - Examples: EUSA elections, music festival
- (current approach: it will be made possible by the 'publisher' role) Might it be interesting to allow one-off writers?
  - Example: I see in the past somebody has been invited to write a review

#### Front page
- (current approach: yes) Might it be interesting to have information about current show?
- (current approach: shortened) Are we interested in the full Twitter feed?
- (current approach: not create model right now, but space identified to do so, in 'Highlights' and might be introduced in the future) Would we want to advertise on the website?
- (current approach: no) What about breaking the current navigation into home and main pages, and then separately teams?
- (current approach: absolutely yes) Would we want to promote events on the website?
- Something else that might be desirable on the front page?
- (current approach: total freedom) Does the website have any design standard or requirement (color palette, font, other graphical elements) or does the webmaster have freedom?
- (current approach, yes and yes to default. Help me with that) Shows with pictures? Is it reasonable for the Head of Design to help hosts with that? Default one?

#### Misc
- (current approach: only pages) How much should be migrated from the previous website?
  - Posts, shows, users
  - The less is migrated, the happier your webmaster will be
- What should happen to the website during Fringe?
- (current approach: get rid) How does the 'Anonymous Complaints Form' work? Shouldn't it be integrated in the website?
- Do we want to handle bookings through the website?
- Do you agree with my permissions schema?
- Any suggestion?


## Roadmap
- Associations of users to shows
- Posts, playlists, dynamic pages, etc.
- Bookings and free schedules
- Authentication through openID
- Prerecords
- Create proper Admin Dashboard
- Refine mobile version
- Security
- Testing
- Create admin notifier for server errors and remove provisional email
- Schedule inconsistencies reports
