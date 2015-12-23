prefix=/usr/local
mandir=$(prefix)/share/man
bindir=$(prefix)/bin
sysconfdir=/etc
INSTALL=/usr/bin/install

man: vws.1 find_free_port.1

%.1:%.mkd
	pandoc -s -t man -o $@ $+

clean:
	rm *.1

install: vws vws.1 find_free_port.1 vws.conf
	$(INSTALL) -d -m 755 -o root $(DESTDIR)$(bindir)
	$(INSTALL) -d -m 755 -o root $(DESTDIR)$(mandir)
	$(INSTALL) -d -m 755 -o root $(DESTDIR)$(mandir)/man1
	$(INSTALL) -c -m 755 -o root find_free_port $(DESTDIR)$(bindir)
	$(INSTALL) -c -m 755 -o root vws $(DESTDIR)$(bindir)
	[ -f $(DESTDIR)$(sysconfdir)/vws.conf ]|| $(INSTALL) -c -m 644 -o root vws.conf $(DESTDIR)$(sysconfdir)
	$(INSTALL) -c -m 644 -o root vws.1 $(DESTDIR)$(mandir)/man1
	$(INSTALL) -c -m 644 -o root find_free_port.1 $(DESTDIR)$(mandir)/man1