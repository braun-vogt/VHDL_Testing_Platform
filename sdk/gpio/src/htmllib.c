/* htmllib.c
 * HTML common library functions for the CGI programs. */

#include <stdio.h>
#include "htmllib.h"

void htmlHeader(char *title) {

	printf("Content-type: text/html\n\n"
			"<html>\<head>\n<meta charset=\"UTF-8\">\n<TITLE>%s</TITLE>\n"
			"<link rel=\"stylesheet\" href=\"../css/bootstrap.min.css\">\n"
			"<script type=\"text/javascript\" src=\"/lang/b28n.js\">\n</script>\n"
			"<script type=\"text/javascript\" src=\"/lang/webcam.js\">\n</script>\n"
			"</head>",
			title);
	printf("<script src=\"../js/jquery-3.4.1.min.js\">\n</script>\n");
	printf("<script src=\"../js/bootstrap.bundle.min.js\">\n</script>\n");
	addUserModal("userModal");
}

void addUserModal(char *id){
	printf("<!-- Modal --> \
<div class=\"modal fade\" id=\"%s\" tabindex=\"-1\" role=\"dialog\" aria-labelledby=\"userModalLabel\" aria-hidden=\"true\"> \
  <div class=\"modal-dialog\" role=\"document\"> \
    <div class=\"modal-content\"> \
      <div class=\"modal-header\"> \
        <h5 class=\"modal-title\" id=\"userModalLabel\">Modal title</h5> \
        <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Close\"> \
          <span aria-hidden=\"true\">&times;</span> \
        </button> \
      </div> \
      <div class=\"modal-body\"> \
        BLA \
      </div> \
      <div class=\"modal-footer\"> \
        <button type=\"button\" class=\"btn btn-secondary\" data-dismiss=\"modal\">Close</button> \
        <button type=\"button\" class=\"btn btn-primary\">Save changes</button> \
      </div> \
    </div> \
  </div> \
</div>", id);
}

void timerScript(int year, int month, int day, int hour, int minute, int second){
	printf("<script>");
	printf("var countDownDate = new Date(%d, %d, %d, %d, %d, %d).getTime();", year, month, day, hour, minute, second);

	printf("var x = setInterval(function() { \
\
  var now = new Date().getTime(); \
\
  var distance = countDownDate - now;\
\
  var days = Math.floor(distance / (1000 * 60 * 60 * 24)); \
  var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60)); \
  var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60)); \
  var seconds = Math.floor((distance % (1000 * 60)) / 1000); \
\
  document.getElementById(\"timer\").innerHTML = days + \"d \" + hours + \"h \" \
  + minutes + \"m \" + seconds + \"s \"; \
\
  if (distance < 0) { \
    clearInterval(x); \
    document.getElementById(\"timer\").innerHTML = \"EXPIRED\"; \
	alert(\"LOGOUT!\");\
  } \
}, 1000); \
</script>");

}

void htmlBody() {
	printf("<body onload=\"page_init()\" oncontextmenu=\"return false;\">");
}

void htmlFooter() {
	printf("</body></html>");
}

void addTitleElement(char *title) {
	printf("<H1>%s</H1>", title);
}
