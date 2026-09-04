\version "2.24"
\include "functions.ly"

%{ === SETTINGS ========================================================== %}

%{ change stuff here to configure the header; delete what you don't need %}
\header {
  title = "My Title"
  subtitle = "Subtitle"
  subsubtitle = "Sub-Sub-Title"
  composer = "Composer"
  poet = "Poet"
  arranger = "Arranger"
  meter = "Meter"
}
%{ end header %}

%{ misc settings %}
keyScore = \key c \major
timeScore = \time 4/4
midiTempo = \tempo 2 = 120
startBar = \set Score.currentBarNumber = #1
%{ end misc %}

%{ set main and secondary voices; main staves are normal sized with thicker
   lines, secondary gets smaller staves with thinner lines %}
sopranoRole = "secondary"
altoRole = "main"
tenorRole = "secondary"
bassRole = "secondary"
%{ end roles %}

%{ === LYRICS ============================================================ %}

%{ words; put phrases that repeat into their own vars %}
wPhraseOne = \lyricmode { I -- ni -- tial Phrase }
%{ end phrases %}

%{ words; write the lyrics for the voices %}
sopranoWords = \lyricmode {
  \wPhraseOne
}
altoWords = \lyricmode {
  \wPhraseOne
}
tenorWords = \lyricmode {
  \wPhraseOne
}
bassWords = \lyricmode {
  \wPhraseOne
}
%{ end lyrics %}

%{ === MUSIC  ============================================================ %}

%{ music for the voices %}
sopranoMusic = \relative c' {
  c'4 d e g
}
altoMusic = \relative c' {
  c'4 d e g
}
tenorMusic = \relative c {
  c'4 d e g
}
bassMusic = \relative c {
  c'4 d e g
}
%{ helper to manage line breaks %}
breakMusic = { }
%{ end music %}

%{ === INTERNAL  ========================================================= %}

%{ in most cases, you shouldn't need to touch anything below here %}
\score {
  \new ChoirStaff \with {
    \RemoveEmptyStaves
    midiInstrument = "electric piano 1"
  } <<
    \startBar
    \new Staff "soprano" \with {
      instrumentName = "Soprano"
      \staffOpts \sopranoRole
    } { \new Voice = "soprano" { \clef treble \timeScore \keyScore \sopranoMusic } }
    \new Lyrics { \lyricsto "soprano" { \lyricOpts \sopranoRole \sopranoWords } }
    \new Staff = "alto" \with {
      instrumentName = "Alto"
      \staffOpts \altoRole
    } { \new Voice = "alto" { \clef treble \keyScore \altoMusic } }
    \new Lyrics { \lyricsto "alto" { \lyricOpts \altoRole \altoWords } }
    \new Staff = "tenorbass" \with {
      instrumentName = "Tenor/Bass"
      \staffOpts \tenorRole
      \consists Merge_rests_engraver
    } { <<
      \new Voice = "tenor" { \clef bass \keyScore \voiceOne \tenorMusic }
      \new Voice = "bass" { \clef bass \keyScore \voiceTwo \bassMusic }
      \new NullVoice = "breaks" { \breakMusic }
      >>
    }
    \new Lyrics \with { alignAboveContext = "tenorbass" } { \lyricsto "tenor" { \lyricOpts \tenorRole \tenorWords } }
    \new Lyrics { \lyricsto "bass" { \lyricOpts \bassRole \bassWords } }
  >>
  \layout {
    \context { \Lyrics
      \override VerticalAxisGroup.staff-affinity = ##f
      \override VerticalAxisGroup.staff-staff-spacing = #'((basic-distance . 0)
                                                           (minimum-distance . 2)
                                                           (padding . 2)) }
    \context { \Staff
      \override VerticalAxisGroup.staff-staff-spacing = #'((basic-distance . 0)
                                                           (minimum-distance . 2)
                                                           (padding . 2)) }
  }
  \midi { \midiTempo }
}
%{ the end, happily ever after, and what have you %}
