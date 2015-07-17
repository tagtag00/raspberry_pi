# Raspberry Pi へのレシピ適用

①raspberry piへchef-soloのセットアップ
knife solo prepare コマンドが利用できないため、
手動でruby,rubygem,bundler,chefのインストールを行う。

  $ curl -O http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.6.tar.gz
  $ sudo tar xzf ruby-2.1.6.tar.gz
  $ cd ruby-2.1.6/
  $ sudo ./configure --disable-install-doc
  $ sudo make
  $ sudo make install
  $ sudo gem install chef

