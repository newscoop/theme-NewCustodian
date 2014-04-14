  <!-- JavaScript at the bottom for fast page loading -->

  <!-- scripts concatenated and minified via ant build script-->
  <script src="{{ url static_file='_js/plugins.js' }}"></script>
  <script src="{{ url static_file='_js/script.js' }}"></script>
  <script src="{{ url static_file='_js/libs/bootstrap-transition.js' }}"></script>
  <script src="{{ url static_file='_js/libs/bootstrap-collapse.js' }}"></script>
  {{ if $gimme->article->defined }}
      <script src="{{ url static_file='_js/article-rating.js' }}"></script>
  {{ /if }}
    <script src="{{ uri static_file="_js/libs/plupload/js/plupload.full.js" }}"></script>
  <script type="text/javascript">
		$(".collapse").collapse()
  </script>
  
  <!-- end scripts-->


  <!--[if lt IE 7 ]>
    <script src="{{ url static_file='_js/libs/dd_belatedpng.js' }}"></script>
    <script>DD_belatedPNG.fix("img, .png_bg"); // Fix any <img> or .png_bg bg-images. Also, please read goo.gl/mZiyb </script>
  <![endif]-->


  <!-- mathiasbynens.be/notes/async-analytics-snippet Change UA-XXXXX-X to be your site's ID -->
  <script>
    var _gaq=[["_setAccount","UA-XXXXX-X"],["_trackPageview"]];
    (function(d,t){var g=d.createElement(t),s=d.getElementsByTagName(t)[0];g.async=1;
    g.src=("https:"==location.protocol?"//ssl":"//www")+".google-analytics.com/ga.js";
    s.parentNode.insertBefore(g,s)}(document,"script"));
  </script>

  <script type="text/javascript">
    $(document).ready(function(){
    $('a.show-feedback-form').live('click', function(e){
        e.preventDefault();
        $.fancybox({
            width: 440,
            'autoDimensions'    : false,
            'content' : $("#feedback-form").html(),
            'onComplete' : function(upcoming, current) {
                $('#fancybox-content .input-file').attr('id', 'plupload-container');
                $('#fancybox-content .input-file .upload').attr('id', 'plupload-choose-file');
                var uploader = new plupload.Uploader({
                    runtimes : 'html5,flash,silverlight',
                    browse_button : 'plupload-choose-file',
                    container : 'plupload-container',
                    max_file_size : '10mb',
                    url : '{{ $view->baseUrl("/feedback/upload/?format=json") }}',
                    flash_swf_url : '{{ $view->baseUrl("/js/plupload/js/plupload.flash.swf") }}',
                    silverlight_xap_url : '{{ $view->baseUrl("/js/plupload/js/plupload.silverlight.xap") }}',
                    filters : [
                        {title : "Image files", extensions : "jpg,gif,png,JPG,GIF,PNG"},
                        {title : "Pdf files", extensions : "pdf"}
                    ]
                });
 
                uploader.bind('Init', function(up) {
                    var is_firefox = navigator.userAgent.toLowerCase().indexOf('firefox') > -1;
                    if (is_firefox) {
                        uploader.refresh();
                    }
                });
 
                uploader.init();
 
                uploader.bind('FilesAdded', function(up, files) {
                    $('#fancybox-content form#feedback-form-form div.show-value').html('Uploading...');
                    up.start();
 
                    up.refresh(); // Reposition Flash/Silverlight
                });
 
                uploader.bind('FileUploaded', function(up, file, info) {
                    $('#fancybox-content form#feedback-form-form div.show-value').html('Uploaded!');
                    var response = $.parseJSON(info['response'])['response'].split("_");
                    $('#fancybox-content form#feedback-form-form .file-holder').html('<input type="hidden" id="feedback-attachment-id" name="attachment_id" /><input type="hidden" id="feedback-attachment-type" name="attachment_type" />')
                    $('#fancybox-content form#feedback-form-form input#feedback-attachment-type').val(response[0]);
                    $('#fancybox-content form#feedback-form-form input#feedback-attachment-id').val(response[1]);
 
                    up.refresh();
                });
            }
        });
    });
    $('form#feedback-form-form').live('submit', function(e) {
        e.preventDefault();
        var form = this;
 
        {{ dynamic }}
        var data = {
            f_feedback_url: String(document.location),
            f_feedback_subject: $('input#feedback-subject', form).val(),
            f_feedback_content: $('textarea#feedback-content', form).val(),
            f_language: '{{ $gimme->language->number }}',
            f_section: '{{ $gimme->section->id }}',
            f_article: '{{ $gimme->article->number }}',
            f_publication: '{{ $gimme->publication->identifier }}',
        };
        {{ /dynamic }}
 
        if ($('#fancybox-content form#feedback-form-form input#feedback-attachment-type').val() == 'image') {
            data['image_id'] = $('#fancybox-content form#feedback-form-form input#feedback-attachment-id').val();
        } else {
            data['document_id'] = $('#fancybox-content form#feedback-form-form input#feedback-attachment-id').val();
        }
 
        $.ajax({
            type: 'POST',
            url: '{{ $view->baseUrl("/feedback/save/?format=json") }}',
            data: data,
            dataType: 'json',
            success: function(data) {
                var message;
                $.fancybox({
                    'content' : '<h2 style="text-align:center;"><span>Response</span></h2><h2 style="text-align:center;">'+ data['response'] +'<h2>'
                });
            }
        });
    });
});
    </script>

</body>
</html>