
%{ do not touch unless you know what you're doing :-) %}
staffOpts = #(define-music-function (role) (string?)
   (let* ((ismain (string=? role "main"))
          (scale (if ismain 1.0 0.85))
          (vol (if ismain 1.0 0.75))
          (girth (if ismain 2 0.75)))
   #{
     \magnifyStaff #scale
     \override StaffSymbol.thickness = #girth
     \set Staff.midiMinimumVolume = #vol
     \set Staff.midiMaximumVolume = #vol
   #}))
lyricOpts = #(define-music-function (role lyrics) (string? ly:music?)
  (let* ((ismain (string=? role "main"))
         (scale (if ismain 1.0 0.85)))
   #{
     \magnifyMusic #scale
     #lyrics
   #}))
ttempo = #(define-music-function (term) (string?) #{
  \tempo \markup { $term } #})
bmark = #(define-music-function (term) (string?) #{
  \mark \markup { \box $term } #})
dyntxt = #(define-music-function (dyn term) (string? string?) #{
  ^\markup { \dynamic $dyn \italic $term } #})
itext = #(define-music-function (term) (string?) #{
  ^\markup { \italic $term } #})
loop = #(define-music-function (term cnt) (ly:music? integer?)
  #{ \repeat unfold $cnt { $term } #})
%{ end do not touch %}
