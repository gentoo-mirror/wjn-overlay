# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MY_P="${P/_/-}"

DESCRIPTION="Audacious Player - Your music, your way, no exceptions"
HOMEPAGE="http://audacious-media-player.org/"
SRC_URI="http://distfiles.audacious-media-player.org/${MY_P}.tar.bz2"

LICENSE="BSD sndfile? ( GPL-2+ ) filewriter? ( GPL-2+ ) libnotify? ( GPL-3+ ) pulseaudio? ( GPL-2+ ) spectrum? ( GPL-2+ )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="aac adplug alsa bs2b cdda cue ffmpeg +filewriter flac gnome jack lame libav
	libnotify libsamplerate lirc midi mms modplug mp3 neon pulseaudio scrobbler
	sdl sid sndfile soxr spectrum vorbis wavpack"

COMMON_DEPEND=">=dev-libs/dbus-glib-0.60
	dev-libs/libxml2:2
	~media-sound/audacious-3.5.2
	>=sys-apps/dbus-0.6.0
	x11-libs/gtk+:3
	aac? ( >=media-libs/faad2-2.7 )
	adplug? ( >=dev-cpp/libbinio-1.4 )
	alsa? ( >=media-libs/alsa-lib-1.0.16 )
	bs2b? ( media-libs/libbs2b )
	cdda? ( >=media-libs/libcddb-1.2.1
		>=dev-libs/libcdio-0.70
		>=dev-libs/libcdio-paranoia-0.70 )
	cue? ( media-libs/libcue )
	ffmpeg? ( >=virtual/ffmpeg-0.7.3 )
	flac? ( >=media-libs/libvorbis-1.0
		>=media-libs/flac-1.2.1-r1 )
	jack? ( >=media-libs/bio2jack-0.4
		media-sound/jack-audio-connection-kit )
	lame? ( media-sound/lame )
	libav? ( media-video/libav )
	libnotify? ( x11-libs/libnotify )
	libsamplerate? ( media-libs/libsamplerate )
	lirc? ( app-misc/lirc )
	modplug? ( media-libs/libmodplug )
	midi? ( >=media-sound/fluidsynth-1.0.6 )
	mms? ( >=media-libs/libmms-0.3 )
	mp3? ( >=media-sound/mpg123-1.12.1 )
	neon? ( >=net-libs/neon-0.26.4 )
	pulseaudio? ( >=media-sound/pulseaudio-0.9.3 )
	scrobbler? ( >=net-misc/curl-7.9.7 )
	sdl? ( || ( >=media-libs/libsdl-1.2.11[sound]
			>=media-libs/libsdl2-2.0[sound] ) )
	sid? ( >=media-libs/libsidplayfp-1.0.0 )
	sndfile? ( >=media-libs/libsndfile-1.0.17-r1 )
	soxr? ( media-libs/soxr )
	spectrum? ( virtual/opengl )
	vorbis? ( >=media-libs/libvorbis-1.2.0
		  >=media-libs/libogg-1.1.3 )
	wavpack? ( >=media-sound/wavpack-4.50.1-r1 )"
DEPEND="${COMMON_DEPEND}
	|| ( >=dev-libs/glib-2.32.2
		dev-util/gdbus-codegen )
	sys-devel/gettext
	virtual/pkgconfig"
RDEPEND=${COMMON_DEPEND}

S="${WORKDIR}/${MY_P}"

src_configure() {
	local ffmpeg_conf=""
	use ffmpeg && ffmpeg_conf="--with-ffmpeg=ffmpeg"
	use libav && ffmpeg_conf="--with-ffmpeg=libav"
	use mp3 || ewarn \
		"MP3 support is optional, you may want to enable mp3 USE flag"
	econf \
		$(use_enable adplug) \
		$(use_enable aac) \
		$(use_enable alsa) \
		$(use_enable bs2b) \
		$(use_enable cdda cdaudio) \
		$(use_enable cue) \
		${ffmpeg_conf} \
		$(use_enable flac flacng) \
		$(use_enable flac filewriter_flac) \
		$(use_enable jack) \
		$(use_enable gnome gnomeshortcuts) \
		$(use_enable lame filewriter_mp3) \
		$(use_enable libnotify notify) \
		$(use_enable libsamplerate resample) \
		$(use_enable lirc) \
		$(use_enable midi) \
		$(use_enable mms) \
		$(use_enable modplug) \
		$(use_enable mp3) \
		$(use_enable midi amidiplug) \
		$(use_enable neon) \
		$(use_enable pulseaudio pulse) \
		$(use_enable scrobbler scrobbler2) \
		$(use_enable sdl sdlout) \
		$(use_enable sid) \
		$(use_enable sndfile) \
		$(use_enable soxr) \
		$(use_enable vorbis) \
		$(use_enable wavpack)
}
