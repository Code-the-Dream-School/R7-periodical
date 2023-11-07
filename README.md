# README -- Code The Dream Backend Periodical

This repository contains the framework for the application called "periodical" in the following Treehouse video for Active Record Associations in Rails: https://teamtreehouse.com/library/has-many-through-associations .  You should create a git branch called periodical and make your changes there.
When you are done with the application, because you have completed all the changes from the Treehouse videos, you can git add, commit, and push your changes and
make a pull request.

The first thing you will have to do is to complete the setup.  This is described in the Teacher's Notes at the link above.  You do not do the rails new command,
as that has been done for you.  You start with the rails g model Subscriber command as described in the notes and complete the directions in those notes and in the
video.


 has_many :through basically says that one model is associated with many instances of another model through a third model. 

 rails g model Subscriber name:string
rails g model Magazine title:string
bin/rails db:migrate
bin/rake db:seed

//in console 
Subscriber.create(name: 'Jay')
Subscriber.create(name: 'Pasan')
Magazine.create(title: 'Ruby Reader')
Magazine.create(title: 'iOS Inspired')

 The table for the Subscriptions model has ID fields for the two models it's joining, Subscribers and Magazines.

But in addition to the Subscriber and Magazine ID fields, it also has an ID field of its own, allowing you to look up Subscriptions independently of Subscribers or Magazines.

And because a Subscription is a model on its own, it can also have additional attributes. In has_many :through, two models are still joined by a database table, but that table also represents an entire third model.

Generate Subscription model
bin/rails g model Subscription months:integer subscriber_id:integer magazine_id:integer
bin/rails db:migrate
Need to update model classes with associations
class Subscription < ApplicationRecord
  belongs_to :subscriber
  belongs_to :magazine
end
class Subscriber < ApplicationRecord
  has_many :subscriptions
  has_many :magazines, through: :subscriptions
end
class Magazine < ApplicationRecord
  has_many :subscriptions
  has_many :subscribers, through: :subscriptions
end
Create a subscription to a magazine, add to subscriber:
subscription = Subscription.create(months: 12, magazine: Magazine.find_by(title: "Ruby Reader"))
Subscriber.find_by(name: "Jay").subscriptions << subscription
Subscription now associated with subscriber. Show it with:
pp Subscriber.find_by(name: "Jay").subscriptions
Magazine also associated with subscriber, through subscription. Show it with:
pp Subscriber.find_by(name: "Jay").magazines
Can also auto-create subscription model record by adding magazine direct to subscriber
Subscriber.find_by(name: "Jay").magazines << Magazine.find_by(title: "iOS Inspired")
pp Subscriber.find_by(name: "Jay").subscriptions
Auto-created join model won't have its attributes set so you may need to update those
pp Subscriber.find_by(name: "Jay").subscriptions.last.update(months: 6)
pp Subscriber.find_by(name: "Jay").subscriptions