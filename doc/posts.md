**Posts** have:
- title
- short body
- content
- author
- published status
- tags
- slug

All teams display a body. This is in the model
Teams then display a list of all posts (limited to 6) that have that team associated through TeamScopes (so team.posts.latest_published.limit(6))
then, take the last 4 tags a team has associated, through Posts, (so team.tags.limit(4)) and for each, display a list of the latest posts for that tag


The 'Latest News' section and page contains post.latest_published
In the page there needs to be a pagination


Posts have a scope, which is an integer from [1,2,3]
def sel.scopes
  {
    'Show' => 1,
    'Team' => 2,
    'Station' => 3
  }
end

Then there's two tables: ShowScope and TeamScope. They have the fields (show/team)_id and post_id
You can add ShowScopes through f.has_many and the collection is the current user's shows. The f.has_many should only be displayed if the Post has scope 'show'
You can add ShowScopes through f.has_many and the collection is the current user's shows. The f.has_many should only be displayed if the Post has scope 'show'
For both these models, both their fields are required. Some extra validation is necessary: for any ShowScope, the post_id needs to have scope 1 and viceversa.
For any post with scope 1, it needs to have a ShowScope associated, same goes for TeamScope
For any post with ShowScope, the post user needs to have the show in ShowScope as one of his shows
For any post with TeamScope, the post user needs to be a member of the TeamScope team

------------------------------------------------------------
there are ShowNews
------------------------------------------------------------
For shows hosts wanting to publish content, maybe like a blog to integrate their broadcasting

these need to be assigned a show

these are displayed in show pages and home.
In home the show title is displayed as the author





------------------------------------------------------------
and StationsNews
------------------------------------------------------------
Like, folks, there is the AGM coming up. Or, we're taking applications for fringe. Or, shit like that

displayed in home
In home 'Station' is displayed as the author


------------------------------------------------------------
and TeamNews
------------------------------------------------------------
Like, the music team is covering Glastonsbury
Or, the sports team talks about Rugby, like always

they need to be assigned to a team

displayed in home and team page
In home the author is the team
In team page the author is the user




Posts have metadata, which is a model of its own (PostMetaData), with fields:
key:string
value:text
post_id:integer

MetaData is added to posts through f.has_many

Metadata needs to be validated

# In model/post_meta_data.rb
def self.allowed_keys
  [rating]
end

def self.allowed_key?(key)
  PostMetaData.include?(key)
end

# In validators/post_meta_data_validator
record.errors[:key] << 'This is not valid metadata' if !PostMetaData.allowed_key?(record.key)


Rating needs to be validated
# In model/post_meta_data.rb

def self.valid_rating?(rating)
  num_rating = number_or_nil(rating)
  return false if (num_rating.nil? or num_rating > 10 or num_rating < 0)
  true
end

private

  def number_or_nil(string)
    num = string.to_i
    num if num.to_s == string
  end

# In validators/post_meta_data_validator
record.errors[:value] << 'The rating you inserted is not valid' if record.key == 'rating' and !PostMetaData.valid_rating?(record.content)






teams.
