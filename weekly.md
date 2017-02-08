---
layout: default
title: Weeklies
---

<div>
  <header class="furore_intro">
  <div class="archive_intro">
  {% capture my_include %}{% include intro-furore.md %}{% endcapture %}
  {{ my_include | markdownify }}
  </div>
  </header>

  <div class="furore_week_links">
  {% assign posts = site.furore | sort: 'date' | reverse %}
  {% assign lastyear = 0 %}
  {% assign lastweek = 0 %}
  {% for post in posts %}
  {% assign year = post.enddate | date: "%Y" %}
  {% assign hid = post.date | date: "%Y-%m-%d" %}
  {% if year != lastyear %}<span class="furore_year_link">{{year}}: </span>{% assign lastyear = year %}{% endif %}
  {% if post.week != lastweek %}
   <span class="furore_week_link"><a href="#{{hid}}">{{post.week}}</a></span>
   {% assign lastweek = post.week %}
  {% endif %}
  {% endfor %}
  </div>

  {% for post in posts %}
  {% if post.date != lastdate %}
  {% assign hid = post.date | date: "%Y-%m-%d" %}
  <div class="furore_date" id="{{ hid }}">
   {{ post.date | date: "%d %B %Y" }} - {{ post.enddate | date:" %d %B %Y" }} (Week #{{post.week}})
  </div>
  {% endif %}
  {% assign lastdate = post.date %}
  <div class="furore_entry">
    <div class="furore_author">
    {% assign author = site.authors | where:"uid",post.uid | first %}
    {% if author.photo %}
     <img src="/assets/img/{{ author.photo }}.png" height="50px" /><br />
    {% else %}
     <img src="/assets/img/generic-headshot.png" height="50px" /><br />
    {% endif %}
    {% if author %}{{ author.fullname }}{% else %}TODO: {{ post.uid }}{% endif %}
    </div>
    <div class="furore_output">{{ post.output }}</div>
  </div>
  <br />
  {% endfor %}
</div>
