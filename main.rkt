#!/usr/bin/env racket
#lang racket/base

(require libmpdclient
         racket/cmdline
         racket/list)

(define conn  (mpd_connection_new "localhost" 6600 1000))

(define (do-seek cmd)
  (case cmd
    [("next")  (mpd_run_next conn)]
    [("prev")  (mpd_run_previous conn)]))

(command-line
  #:program "rktmpc"
  #:once-each
  [("-p" "--play")
    "Play MPD." 
    (mpd_run_pause conn #f)]
  [("-P" "--pause")
    "Pause MPD."
    (mpd_run_pause conn #t)]
  [("-s" "--seek") cmd
    "Controls various MPD playback functions."
    (do-seek cmd)])
