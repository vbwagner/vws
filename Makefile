prefix=/usr/local
mandir=$(prefix)/share/man
bindir=$(prefix)/bin
sysconfdir=/etc
initddir=$(sysconfdir)/init.d
systemddir=/lib/systemd/system
INSTALL=/usr/bin/install

man: vws.1 find_free_port.1

%.1:%.mkd
	pandoc -s -t man -o $@ $+

clean:
	rm -f *.1 vws.service

vws.service: vws.service.in
	sed 's!@bindir@!$(bindir)!' $+ > $@

install: vws vws.1 find_free_port.1 vws.conf vws.service
	[ -d $(DESTDIR)$(bindir) ] || $(INSTALL) -d -m 755 -o root $(DESTDIR)$(bindir)
	[ -d $(DESTDIR)$(mandir) ] || $(INSTALL) -d -m 755 -o root $(DESTDIR)$(mandir)
	[ -d $(DESTDIR)$(mandir)/man1 ]||$(INSTALL) -d -m 755 -o root $(DESTDIR)$(mandir)/man1
	[ -d $(DESTDIR)$(systemddir) ] || $(INSTALL) -d -m 755 -o root $(DESTDIR)/lib/systemd/system
	[ -d $(DESTDIR)$(sysconfdir)] || $(INSTALL) -d -m 755 -o root $(DESTDIR)$(sysconfdir)
	[ -d $(DESTDIR)$(initddir)] || $(INSTALL) -d -m 755 -o root $(DESTDIR)$(initddir)
	$(INSTALL) -c -m 755 -o root find_free_port $(DESTDIR)$(bindir)
	$(INSTALL) -c -m 755 -o root vws $(DESTDIR)$(bindir)
	
	[ -f $(DESTDIR)$(sysconfdir)/vws.conf ]|| $(INSTALL) -c -m 644 -o root vws.conf $(DESTDIR)$(sysconfdir)
	$(INSTALL) -c -m 644 -o root vws.1 $(DESTDIR)$(mandir)/man1
	$(INSTALL) -c -m 644 -o root find_free_port.1 $(DESTDIR)$(mandir)/man1
	$(INSTALL) -c -m 644 -o root vws.service $(DESTDIR)$(systemddir)
	$(INSTALL) -c -m 644 -o root vws.init $(DESTDIR)$(initddir)/vws
