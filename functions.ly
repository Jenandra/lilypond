
%{ do not touch unless you know what you're doing :-) %}
staffOpts = #(define-music-function
   (role scalelist) (string? list?)
   (let* ((ismain (string=? role "main"))
          (scale (if ismain
		(list-ref scalelist 0) (list-ref scalelist 1))
	  )
          (vol (if ismain
		(list-ref scalelist 2) (list-ref scalelist 3))
	  )
          (girth (if ismain
		(list-ref scalelist 4) (list-ref scalelist 5))
	  ))
   #{
     \magnifyStaff #scale
     \override StaffSymbol.thickness = #girth
     \set Staff.midiMinimumVolume = #vol
     \set Staff.midiMaximumVolume = #vol
   #}))
lyricOpts = #(define-music-function
  (role lyrics scalelist) (string? ly:music? list?)
  (let* ((ismain (string=? role "main"))
         (scale (if ismain (list-ref scalelist 0) (list-ref scalelist 1))))
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
tmark = #(define-music-function (term) (string?) #{
  \textMark \markup { \tiny \italic { $term } } #})
%{ end do not touch %}
