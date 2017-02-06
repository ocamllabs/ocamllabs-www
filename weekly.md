---
layout: default
title: Weeklies
---

<div>
  <header>Weekly notes about activities in the group.</header>

  <section class="archive_list">
    {% assign posts = site.furore | sort: 'date' | reverse %}
    {% for post in posts %}
    {% assign currentdate = post.date | date: "%Y %m" %}
    {% assign currentweek = post.week %}
    {% if currentdate != date %}
      <div class="archive_date_header"><span class="text">{{ post.date | date: "%d %B %Y" }}</span></div>
      {% assign date = currentdate %}
    {% endif %}

    <div class="post_title_light">
      {% assign author = site.authors | where:"uid",post.uid | first %}
      {% if author.photo %}<div style="float:left; padding: 10px"><img src="/assets/img/{{ author.photo }}.png" height="50px" /></div>{% endif %}
      <h3>{% if author %}{{ author.fullname }}{% else %}TODO: {{ post.uid }}{% endif %}</h3>
      <blockquote>
      {{ post.output }}
      </blockquote>
    </div>
    {% endfor %}
  </section>
</div>
