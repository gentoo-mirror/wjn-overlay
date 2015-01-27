#オーバーレイのインストールのしかた

----
## 1. 管理しやすそうな任意の場所に git clone します。

例:

    /home/you$ mkdir overlay  
    /home/you$ cd overlay  
    /home/you/overlay$ git clone git://bb.asis.li/wjn-overlay.git  

これで、/home/you/overlay/wjn-overlay にまるごとダウンロードされました。


----
## 2. PORTDIR_OVERLAY の設定
/etc/make.conf などで PORTDIR_OVERLAY に上記ディレクトリパスを代入します。

    PORTDIR_OVERLAY="
    /home/you/overlay/wjn-overlay
    "

----
## 3. /etc/portage/package.mask の設定

意図せずオーバーレイから emerge してしまわないため、まずマスクをかけます。

    */*::wjn-overlay

----
## 4. /etc/portage/package.unmask の設定

emerge したいものだけマスクを外します。

例:

    media-sound/audacious::wjn-overlay  
    media-plugins/audacious-plugins::wjn-overlay

----
## 5. /etc/portage/package.accept_keywords の設定

ebuild 内に アーキテクチャの KEYWORD がないものは、
/etc/portage/package.accept_keywords に追加する必要があります。

例:

    media-sound/audacious::wjn-overlay **  
    media-plugins/audacious-plugins::wjn-overlay **

アスタリスク２つを指定することで、
KEYWORD なしの ebuild も受け入れるようになります。
cf. [Gentoo Wiki](https://wiki.gentoo.org/wiki/Knowledge_Base:Accepting_a_keyword_for_a_single_package#Additional_notes)

上記例では、 emerge audacious audacious-plugins をすると、
バージョン9999 (Git 版)が emerge されます。

------
wjn

