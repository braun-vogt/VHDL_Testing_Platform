var page_acc=3;

var ptz_saveshow = 0;

      var imageNr = 0; // Serial number of current image
      var finished = new Array(); // References to img objects which have finished downloading
      var paused = false;
      var previous_time = new Date();
	
      function createImagePlayer() {
        var img = new Image();
        img.style.position = "absolute";
        img.style.zIndex = -1;
        img.onload = imageOnload;
        //img.onclick = imageOnclick;
        //img.width = "100%";
        img.src = "http://192.168.1.254/media/?action=snapshot"  + (++imageNr);;
        var webcam = document.getElementById("webcam");
        webcam.insertBefore(img, webcam.firstChild);
      }

      // Two layers are always present (except at the very beginning), to avoid flicker
      function imageOnload() {
        this.style.zIndex = imageNr; // Image finished, bring to front!
        while (1 < finished.length) {
          var del = finished.shift(); // Delete old image(s) from document
          del.parentNode.removeChild(del);
        }
        finished.push(this);
        current_time = new Date();
        delta = current_time.getTime() - previous_time.getTime();
        //fps   = (1000.0 / delta).toFixed(3);
        //document.getElementById('info').firstChild.nodeValue = delta + " ms (" + fps + " fps)";
        previous_time = current_time;
        if (!paused) createImagePlayer();
      }

      function imageOnclick() { // Clicking on the image will pause the stream
        paused = !paused;
        if (!paused) createImagePlayer();
      }

function page_init() {

    //initTranslation();
    createImagePlayer();
     
    //cmd_frm.init_comp();
}

function refresh_stream()
{
	location.reload();
}
function img_size(vlu)
{
	cmd_frm.imagesize_cmd(vlu);
	setTimeout('refresh_stream()', 1000);
}

var mbptz_dotime = 400;

function delay_run(fun)
{
	setTimeout(fun, mbptz_dotime);
}

