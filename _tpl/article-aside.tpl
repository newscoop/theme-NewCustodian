{{ include file="_tpl/sidebar-loginbox.tpl" }} 
{{* Only if user has the right to read the article, aside elements will be shown. The same for article content. *}}
{{ if $gimme->article->content_accessible }}

{{* This part builds the article gallery. There can also be more than one gallery *}} 
{{ foreach $gimme->article->slideshows as $slideshow }}

          <div id="gallery" class="clearfix">
              <h3>{{ #articleGallery# }}</h3>
              <h4>{{ $slideshow->headline }}</h4>
{{ assign var="counter" value=0 }}              
{{ foreach $slideshow->items as $item }}      
{{ assign var="counter" value=$counter+1 }}
                <a href="http://{{ $gimme->publication->site }}/{{ $item->image->original }}" rel="gallery" class="threecol gallery_thumbnail{{ if $counter%4 == 0 }} last{{ /if }}" title="{{ $item->caption }}" /><img src="{{ $item->image->src }}" width="{{ $item->image->width }}" height="{{ $item->image->height }}" alt="{{ $item->caption }}" style="max-width: 100%" rel="resizable" /></a>                         
{{ /foreach }}
            </div><!-- /#gallery -->

{{ /foreach }}
        
{{* this creates article map with markers for selected POIs *}}        
{{ if $gimme->article->has_map }}         
            <figure id="map-box">
                <h3>{{ #map# }}</h3>
                {{ map show_locations_list="false" show_reset_link="Show initial Map" width="350" height="300" }}
            </figure>  
{{ /if }}

{{* here we work with article attachments. .oga and .ogv/.ogg files is automatically shown with player in html5 enabled browsers (for video we are including videojs.com's HTML5 player which also plays mp4 and webm formats), all other cases just build the link for download *}}           

<!--attachmant-->
{{ if $gimme->article->has_attachments }} 
{{assign var=hasvideo value=0}}
{{ list_article_attachments }}
{{ if $gimme->attachment->extension == oga || $gimme->attachment->extension == mp3 || $gimme->attachment->extension == MP3  }}          
<div class="audio-attachment">
  <h5><i class="icon-headphones"></i> {{ #listen# }}</h5><hr>
    <audio src="{{ uri options="articleattachment" }}" controls></audio><br>
    <a class="btn btn-mini btn-red" href="{{ uri options="articleattachment" }}">{{ #downloadAudioFile# }} | {{ $gimme->attachment->extension }}</a>
</div><!-- /#audio-attachment -->
{{ elseif $gimme->attachment->extension == ogv || $gimme->attachment->extension == ogg || $gimme->attachment->extension == flv || $gimme->attachment->extension == mp4 || $gimme->attachment->extension == webm }}             
    {{append var=videosources value="{{ uri options="articleattachment" }}" index="`$gimme->attachment->extension`"}}
    {{assign var = hasvideo value = true}}
{{ else }}
<div class="attachment">
    <h5><i class="icon-download-alt"></i> {{ #attachment# }}</h5><hr>
    <a href="{{ uri options="articleattachment" }}" class="btn btn-mini btn-red">{{ #download# }} | {{ $gimme->attachment->file_name }} ({{ $gimme->attachment->size_kb }}kb)</a>
    <p><em>{{ $gimme->attachment->description }}</em></p>
</div><!-- /.attachment -->
{{ /if }}

{{ /list_article_attachments }}      
{{ /if }}  

{{ if $hasvideo == true }}
<div class="video-attachment"><!-- read http://diveintohtml5.org/video.html -->
  <h5 id="video-cont-label"><i class="icon-film"></i> {{ #watch# }}</h5><hr>
    <div class="flowplayer" data-engine="flash" data-swf="{{ url static_file='_js/vendor/flowplayer/flowplayer.swf' }}" data-ratio="0.417">
      <video >
        {{foreach from=$videosources key=extension item=videoSource name=videoLoop}}
        <source src="{{ $videoSource }}" type='video/{{if $extension == flv }}flash{{ elseif $extension == ogv}}ogg{{ else }}{{ $extension }}{{ /if }}'>
        {{/foreach}}
      </video>
    </div>
    {{foreach from=$videosources key=extension item=videoSource name=videoLoop}}
    <a href="{{ $videoSource }}" class="btn btn-mini btn-red">{{ #download# }} | {{ $extension }}</a>
    {{/foreach}}
</div><!-- /#video-attachment --> 
{{ /if }}
<!--attachmant-->






{{ /if }}{{* end of $gimme->article->content_accessible *}}

{{* here we include debate voting tool, if article type is 'debate' *}}
{{ if $gimme->article->type_name == "debate" }}
{{ include file="_tpl/debate-voting.tpl" }}

{{ else }}

{{* here we show short bio of article authors for article of non-debate type *}}

{{ list_article_authors }} 
{{ if $gimme->current_list->at_beginning }}            
            <div id="author-box">
              <h3>{{ #aboutAuthor# }}</h3>
{{ /if }}              
                <article class="clearfix">
               
                	 <figure class="threecol">
          {{ strip }}
            {{ if $gimme->author->picture->imageurl }}
            <img src="{{ $gimme->author->picture->imageurl }}" alt="{{ $gimme->author->name }}" width="{{ $width }}" />
            {{ else }}
              <img alt="{{ $user->uname|escape }}" src="{{ url static_file='_img/user_blank_156x156.png'}}" />
            {{ /if }}
            {{ /strip }}
                  </figure>

                    <div class="ninecol last">
                	<h4>{{ if $gimme->author->user->defined }}<a href="{{ $view->url(['username' => $gimme->author->user->uname], 'user') }}">{{ /if }}{{ $gimme->author->name }}{{ if $gimme->author->user->defined }}</a>{{ /if }}</h4>
                  
                  <p>{{ $gimme->author->biography->text|html_entity_decode}}</p>
  
                    </div>
                </article>

{{ if $gimme->current_list->at_end }}                             
            </div><!-- /#author-box -->
{{ /if }}
{{ /list_article_authors }}            

{{ /if }}
                
{{* related content *}}                
            <div id="related">
            
{{ list_related_articles }}
{{ if $gimme->current_list->at_beginning }}
                <h3>{{ #relatedArticles# }}</h3>
        			 <ul>
{{ /if }}        			 
                    <li><a href="{{ uri options="article" }}">{{ $gimme->article->name }}</a></li>
{{ if $gimme->current_list->at_end }}     
                </ul>
{{ /if }}                    
{{ /list_related_articles }}                                               
            
            
                <h3>{{ #moreInThisSection# }}</h3>
        <ul>
{{ assign var="curart" value=$gimme->article->number }}        
{{ list_articles length="5" ignore_issue="true" order="bypublishdate desc" constraints="number not $curart" }}
                    <li><a href="{{ uri options="article" }}">{{ $gimme->article->name }}</a></li>
{{ /list_articles }}                    
                </ul>                
            </div><!-- /#related -->