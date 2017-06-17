**Posts** have:

All teams display a body. This is in the model
Teams then display a list of all posts (limited to 6) that have that team associated through TeamScopes (so team.posts.latest_published.limit(6))
then, take the last 4 tags a team has associated, through Posts, (so team.tags.limit(4)) and for each, display a list of the latest posts for that tag


The 'Latest News' section and page contains post.latest_published
In the page there needs to be a pagination
