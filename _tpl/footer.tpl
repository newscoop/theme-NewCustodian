    <footer class="row">
      <ul class="clearfix main-nav">
      	 {{ set_current_issue }}    
          {{ list_sections }}       
          <li><a href="{{ url options="section" }}" title="{{ $gimme->section->name }}">{{ $gimme->section->name }}</a></li>
          {{ /list_sections }}      
          <li><a href="{{ $view->url(['controller' => 'user', 'action' => 'index'], 'default') }}" title="Community index">{{ #community# }}</a></li>
      </ul>
      <ul class="clearfix sec-nav">
      	 {{ local }}
    		 {{ unset_topic }}
          {{ list_articles ignore_issue="true" ignore_section="true" constraints="issue is 1 section is 5"}}
          <li><a href="{{ uri options="article" }}" title="{{ $gimme->article->name }}">{{ $gimme->article->name }}</a></li>
          {{ /list_articles }}
                   
          <li><a href="{{ uri options="template archive.tpl" }}">{{ #archives# }}</a></li>

          <li><a href="#" class="show-feedback-form">Show Feedback</a></li>
      </ul>      
    <p>Powered by <a href="http://newscoop.sourcefabric.org/">Newscoop</a>. {{ #designedBy# }} <a href="http://www.sourcefabric.org/">Sourcefabric</a>. {{ #lastUpdate# }} {{ list_articles length="1" ignore_issue="true" ignore_section="true"  order="bypublishdate desc" }}{{ $gimme->article->modify_date|camp_date_format:"%M %y, %Y" }}{{ /list_articles }}</p>

    		 {{ /local }} 
    </footer>

     <div style="display:none;">
    <div id="feedback-form">
      <!-- show only for logged in users -->
      {{ if $gimme->user->logged_in }}
        <div class="popup-form">
        <form method="POST" id="feedback-form-form" action="/feedback/save">
            <h2>Feedback</h2>
            <fieldset>
                <ul>
                    <li>
                    <label>Choose a topic</label>
                        <select class="topic" style="min-width: 276px;">
                            <option value="First topic">First topic</option>
                            <option value="Second topic">Second topic</option>
                        </select>
                    </li>
                    <li>
                        <label>Subject</label>
                        <input type="text" id="feedback-subject" name="subject">
                    </li>
                    <li>
                        <label>Message<i>*</i></label>
                        <textarea cols="" rows="4" id="feedback-content" name="content"></textarea>
                    </li>
                    <li class="input-file red">
                    <label style="display:transparent">Choose file</label>
                        <div class="show-value"></div>
                        <input type="file" class="upload" />
                    </li>
                    <li class="top-line">
                        <div class="file-holder"></div>
                        <input type="submit" class="submit" value="Submit">
                    </li>
                </ul>
            </fieldset>
        </form>
        </div>
    {{ else }}
    <h2 style="text-align: center;">Only for logged in users</h2>
    <p style="text-align: center; font-size: 15px; font-weight: bold; padding-top: 10px;">Login <a href="{{ $view->url(['controller' => 'auth', 'action' =>'index'], 'default') }}">here</a></p>
    {{ /if }}
    </div>
</div>
