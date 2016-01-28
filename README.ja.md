# wjn-overlay
----

Gentoo GNU/Linux 向けの overlay です

追加や最新の情報は、 [Wiki](https://bitbucket.org/wjn/wjn-overlay/wiki/) に書いています

- 本ファイル更新: 2016-01-28

----

## 内容

入っているパッケージの完全なリストは、 [PACKAGE-LIST.md](PACKAGE-LIST.md) にあります

以下は一例です

### 文字変換
    
- [Mozc](https://code.google.com/p/mozc/)  
    (**[uim](https://code.google.com/p/uim/)対応**。公式同様に Clang コンパイル可)  
    
- [Mozc UT Dictionary](http://www.geocities.jp/ep3797/mozc_01.html)  
    (追加辞書付 Mozc。**uim 対応**。公式同様に Clang コンパイル可)  
    <small>※はてなキーワード辞書およびニコニコ大百科(nicodic)辞書機能は、ライセンス不明です  
    　とりわけニコニコ大百科は収載単語が独特で著作性が高く、
    また運営企業は２ちゃんねるで有名な未来検索ブラジルですので、
    無用な紛争に巻き込まれないためにもインストールしないことをお勧めします。
    デフォルトのUSEフラグも無効にしてあります</small>  

- [Mozc NEologd UT Dictionary](http://www.geocities.jp/ep3797/mozc_01.html)  
    ([mecab-ipa-NEologd](https://github.com/neologd/mecab-ipadic-neologd) 由来の追加辞書付 Mozc。**uim 対応**。公式同様に Clang コンパイル可)

- [uim](http://code.google.com/p/uim/)  
    (dev 版、 Qt5 対応)

### テキスト

- [Nikola](http://getnikola.com/)  
  （スタティック サイト ジェネレータ）

- [CuteMarkEd](https://cloose.github.io/CuteMarkEd/)
   (**app-editors**/cutemarked)  
  （マークダウン エディタ）※**Gentoo リポジトリのはバグっているのにバグリポートしても放置されているから**

- [mined](http://towo.net/mined/)  
  （テキストエディタ）

- [青空文庫ビューア (aobook)](http://azsky2.html.xdomain.jp/linux/aobook/index.html)

### マルチメディア

- [AzPainter](http://azsky2.html.xdomain.jp/linux/azpainter/index.html)
- [AzDrawing](http://azsky2.html.xdomain.jp/linux/azdrawing/index.html)

- [Audacious](http://audacious-media-player.org/)  
    (dev 版)
    
- [gdk-pixbuf-psd](http://cgit.sukimashita.com/gdk-pixbuf-psd.git/)  
    (Photoshop の PSD を画像ビューア等で読み込むための gdk-pixbuf ローダ)

- [gdk-pixbuf-xcf(io-xcf)](https://gitorious.org/xcf-pixbuf-loader)  
    (GIMP の XCF を画像ビューア等で読み込むための gdk-pixbuf ローダ)  
    
- [libvdpau-va-gl](https://github.com/i-rinat/libvdpau-va-gl)  
    (VDPAU の OpenGL/VAAPI バックエンドライブラリ)  

### テーマ

- [neu-icon-theme](http://www.silvestre.com.ar/)  
    (GNOME アイコンテーマ)
- [gion-icon-theme](http://www.silvestre.com.ar/)  
    (GNOME アイコンテーマ)

- [faience-icon-theme](http://tiheum.deviantart.com/art/Faience-icon-theme-255099649)
    (GNOME アイコンテーマ)

### フォント

明朝書体は少なく、実用的で modern なものは更に希少。Gentoo リポジトリ内では IPA。以下では花園明朝が実用的。
MogaMicho は IPA と大差がない

手書きは、 **Gentoo リポジトリ内では「あくあフォント」が良好でしたが公式配布終了**。
以下では、「瀬戸フォント」「きろ字」「Y.OzFont」が良好

- Adobe
    + [Souce Han Sans (源ノ角ゴシック)](https://github.com/adobe-fonts/source-han-sans)
    + [Source Han Code JP](https://github.com/adobe-fonts/source-han-code-jp)

- Google
    + [Noto](https://github.com/googlei18n/noto-fonts)
      ※ English のみをインストール
    + [Noto Sans CJK JP](https://github.com/googlei18n/noto-cjk)
    + [Noto Emoji](https://github.com/googlei18n/noto-emoji)

- [M+ と IPA の合成フォント](http://mix-mplus-ipa.osdn.jp/)
    + [Circle M+](http://mix-mplus-ipa.osdn.jp/mplus/)
    + [Pixel Mplus](http://mix-mplus-ipa.osdn.jp/mplus/)
    + [Migu VS, BT, DS](http://mix-mplus-ipa.osdn.jp/migu/)
      (media-fonts/migu-vbd)  
      ※ ライセンスのため、ローカルで合成作業をする

- [自家製フォント工房](http://jikasei.me/font/)
    + [源真ゴシック](http://jikasei.me/font/genshin/)
    + [源柔ゴシック](http://jikasei.me/font/genjyuu/)  
      ※ media-fonts/genju-gothic (jyu ではない)
    + [Mgen+](http://jikasei.me/font/mgenplus/)
    + [Rounded Mgen+](http://jikasei.me/font/rounded-mgenplus/)
    + [（自家製）Rounded M+](http://jikasei.me/font/rounded-mplus/)  
    ※ <http://mix-mplus-ipa.osdn.jp/mplus/>とは異なる

- [Kazesawa](https://github.com/kazesawa/kazesawa)

- [Koruri](http://koruri.lindwurm.biz/)

- [和田研細丸ゴシック](https://osdn.jp/projects/jis2004/)
  (media-fonts/wlmaru)

- [花園丸ゴシック](http://www.mars.dti.ne.jp/glyph/fonts.html)

- [花園明朝](http://fonts.jp/hanazono/)

- [花園明朝OT](http://shiromoji.net/font/HanaMinOT/)

- [戸越フォント](http://togoshi-font.osdn.jp/)  
  ※ 戸越ゴシック, 戸越等幅ゴシック,戸越モナーゴシック, 戸越明朝

- [さわらびフォント](https://osdn.jp/projects/sawarabi-fonts/)
  ※ ゴシック体と明朝体

- [出島明朝](https://code.google.com/p/dejima-fonts/)

- [UTUMI Hirosi 氏](http://www.geocities.jp/ep3797/modified_fonts_01.html)  
  ※ Mozc UT の人  
  ( Note: UmePlus は Gentoo リポジトリにある）
    + UmePlus CL
    + MMCeder
    + Meguri
    + Komatuna
    + Monapo

- [Y.Oz Vox](http://yozvox.web.fc2.com/)
    + [Y.OzFont](http://yozvox.web.fc2.com/82A882B782B782DF8374834883938367.html)  
      (ペン字フォント)
    + [Y.OzFontK&M](http://yozvox.web.fc2.com/82A882B782B782DF8374834883938367.html)
      (media-fonts/yozfontkm)  
      (毛筆フォント)  
    + [Y.OzFontOTW](http://yozvox.web.fc2.com/82A882B782B782DF8374834883938367.html)
      (media-fonts/yozeng)  
      (タイプライター / デジタルディスプレイ風フォント)  
    + [MoboGothic / MogaGothic / MogaMincho](http://yozvox.web.fc2.com/82A882B782B782DF8374834883938367.html)
    (media-fonts/yoz-mobomoga)  
      (M+ / IPAフォント 系 明朝・ゴシック)  

- [瀬戸フォント](http://setofont.sourceforge.jp/)  
  （手書き）  
  ※作者の瀬戸のぞみ氏は、現在では「瀬戸フォント」のみを配布しています <http://nonty.net/sorry/>

- [きろ字](http://www.ez0.net/distribution/font/kiloji/)

- [Typing Art](http://typingart.net/)
    + [はんなり明朝体](http://typingart.net/?p=44)
    + [こころ明朝体](http://typingart.net/?p=46)

- [フリーフォントの樹](http://freefonts.jp/index.html)  
  ※「刻」は、コクと読む
    + [刻明朝](http://freefonts.jp/font-koku-min.html)
    + [刻ゴシック](http://freefonts.jp/font-koku-go.html)

- [フォントな](http://www.fontna.com/)
    + [やさしさアンチック](http://www.fontna.com/blog/1122/)
    + [やさしさゴシック](http://www.fontna.com/blog/379/)

- [小夏](http://www.masuseki.com/?u=be/konatu.htm)  
  （ゴシック）  
  ※ "Konatu Font" が公式名称で、tsu ではない

- [けいふぉんと](http://font.sumomo.ne.jp/font_1.html) (media-fonts/k-font)  
  （アニメ「けいおん！」のロゴ風）

- [OpenType.jp（武蔵システム）配布](http://opentype.jp/freemouhitufont.htm)
    + 青柳疎石フォント (media-fonts/aoyagisoseki)
    + 青柳衡山フォント (media-fonts/aoyagikohzan)
    + TTEdit 半角 (media-fonts/ttedit-half)
    + TTEdit 2/3 (media-fonts/ttedit-twobythree)

### アクセシビリティ

- [Onboard](https://launchpad.net/onboard)

- [xvkbd](http://homepage3.nifty.com/tsato/xvkbd/)
  (**app-accessibility**/xvkbd)  
  ※ Gentoo リポジトリのはカテゴリがおかしい

### その他

----
### ライセンス

GPL v2

----
### 免責条項

このリポジトリの内容は**完全に無保証**です
自分で何をしようとしているか解る人だけが利用してください

----
wjn
