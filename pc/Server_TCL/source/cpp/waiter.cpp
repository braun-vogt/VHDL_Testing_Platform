 #include "../header/waiter.h"
int fd;
int wd;
char removewatch()
{
    inotify_rm_watch( fd, wd );
    close(fd);
}
char waitfornewfiles(configpath_s config)
{
    fd = inotify_init();
    if ( fd < 0 )
    {
        //fprintf(config.log,"failture initing inotify",)
        fprintf(config.log,"error init portfile %s", strerror(errno));
        return -1;
    }

    wd = inotify_add_watch( fd, config.vhdlinpath,events );

    read( fd, stdout, 0 );

    inotify_rm_watch( fd, wd );
    close( fd );
}

