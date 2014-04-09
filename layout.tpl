{{ config_load file="{{ $gimme->language->english_name }}.conf" }}

{{ include file="_tpl/_html-head.tpl" }}

<body>

  <div id="container">
      
{{ include file="_tpl/header.tpl" layout="true" }}
    
    <div class="row clearfix" role="main">    
    
      <div id="maincol" class="community eightcol clearfix">
    
        {{ block content }}{{ /block }}
        
      </div><!-- /#maincol -->
        
      <div id="sidebar" class="community fourcol last">

{{ if !($userindex == 1) }}                  
{{ if $user->isAuthor() }}

<h3>About
    {{ if $profile['first_name_public'] eq 1 }}
        {{ $user->first_name }}
    {{ /if }}
    {{ if $profile['last_name_public'] eq 1 }}
        {{ $user->last_name }}
    {{ /if }}
</h3>
<dl class="profile">
    {{ foreach $profile as $label => $value }}
    {{ if !empty($value) }}
       
        {{ if $label == "bio" }}
                <dt style="margin-left:5px;">Bio:</dt><dd style="overflow:hidden;">{{ $value|default:"n/a" }}</dd>
        {{ /if }}
        {{ if $label == "birth_date" }}
            <dt>Birth Date:</dt><dd>{{ $profile['birth_date'] }}</dd>
        {{ /if }}
        {{ if $label == "geolocation" }}
            <dt>Location:</dt><dd>{{ $profile['geolocation'] }}</dd>
        {{ /if }}
        {{ if $label == "organisation" }}
            <dt>Organisation:</dt><dd>{{ $profile['organisation'] }}</dd>
        {{ /if }}
        {{ if $label == "gender" }}
            <dt>Gender:</dt><dd>{{  $profile['gender'] }}</dd>
        {{ /if }}
        {{ if $label == "website" }}
            <dt>Website:</dt><dd><a rel="nofollow" target="_blank"  href="http://{{ $profile['website'] }}">
    {{ $profile['website'] }}</a></dd>
        {{ /if }}
       
    {{ /if }}
    {{ /foreach }}

     {{ if $profile['email_public'] eq 1}}
            <dt>Email:</dt><dd><a href="mailto:{{ $user->email }}">{{ $user->email }}</a></dd>
    {{ /if }}

    {{ if  !empty($profile['facebook']) }}
        <a rel="nofollow" target="_blank" href="http://facebook.com/{{ $profile['facebook'] }}"><img src="{{ url static_file='_img/icons/fb.png' }}" alt="Facebook"> </a>&nbsp;
    {{ /if }}
    {{ if  !empty($profile['twitter']) }}
    <a rel="nofollow" target="_blank" href="http://twitter.com/{{ $profile['twitter'] }}"><img src="{{ url static_file='_img/icons/tw.png' }}" alt="Twitter"></a>&nbsp;
    {{ /if }}

    {{ if  !empty($profile['google']) }}
    <a rel="nofollow" target="_blank" href="http://plus.google.com/{{ $profile['google'] }}/"><img src="{{ url static_file='_img/icons/gg.png' }}" alt="Google +"></a>&nbsp;
    {{ /if }}

    
</dl> 







{{ include file="_tpl/sidebar-community-feed.tpl" }}  

{{ else }}
 
{{ include file="_tpl/sidebar-community-feed.tpl" }}  
       
{{ include file="_tpl/_banner-sidebar.tpl" }} 

{{ /if }}

{{ else }}

{{ include file="_tpl/sidebar-community-feed.tpl" }}  
            
{{ include file="_tpl/_banner-sidebar.tpl" }}   

{{ /if }} 
            
        </div><!-- /#sidebar -->
    
    </div>
    
{{ include file="_tpl/footer.tpl" }}

  </div> <!-- /#container -->

{{ include file="_tpl/_html-foot.tpl" }}
