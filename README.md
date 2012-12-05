Fixes Ruby 1.8.7 / OpenSSL 1.0.1 / Ubuntu 12.04 LTS / Samurai compatibility issue

This deadly combination of items produces the following error:

    OpenSSL::SSL::SSLError: SSL_connect SYSCALL returned=5 errno=0 state=unknown state
    from /opt/ruby-enterprise-1.8.7-2011.12/lib/ruby/1.8/net/http.rb:586:in `connect'
    from /opt/ruby-enterprise-1.8.7-2011.12/lib/ruby/1.8/net/http.rb:586:in `connect'
    from /opt/ruby-enterprise-1.8.7-2011.12/lib/ruby/1.8/net/http.rb:553:in `do_start'
    from /opt/ruby-enterprise-1.8.7-2011.12/lib/ruby/1.8/net/http.rb:542:in `start'

Due to a set of incompatibilities with the flags for accepting TLSv1.1 and the Samurai servers:
https://bugs.launchpad.net/ubuntu/+source/openssl/+bug/1018998
https://bugs.launchpad.net/ubuntu/+source/openssl/+bug/965371
https://bugs.launchpad.net/ubuntu/+source/openssl/+bug/1035558

Evernote & Shopify also had problems:
http://discussion.evernote.com/topic/26978-ssl-handshake-problems/

You can reproduce this error with curl on Ubuntu 12.04:

    curl https://api.samurai.feefighters.com/v1/
    curl: (35) Unknown SSL protocol error in connection to api.samurai.feefighters.com:443 

    openssl s_client -host 50.115.208.209 -port 443

    CONNECTED(00000003)
    139838637860512:error:140790E5:SSL routines:SSL23_WRITE:ssl handshake failure:s23_lib.c:177:
    ---
    no peer certificate available
    ---
    No client certificate CA names sent
    ---
    SSL handshake has read 0 bytes and written 226 bytes
    ---
    New, (NONE), Cipher is (NONE)
    Secure Renegotiation IS NOT supported
    Compression: NONE
    Expansion: NONE
    ---

Forcing TLSv1 makes it work:

    curl -I --tlsv1 https://api.samurai.feefighters.com/v1/
    # Works!

    openssl s_client -no_tls1_1 -no_tls1_2 -host 50.115.208.209 -port 443 
    # Works!


To fix this error, we can force samurai to use a TLS v1

http://stackoverflow.com/questions/11267856/shopify-ubuntu-12-04lts-faraday-issue-ok-to-use-older-openssl

But Ruby 1.8.7 doesn't support this 'ssl_version' option, so Net::HTTP must be monkey patched as well as ActiveResource