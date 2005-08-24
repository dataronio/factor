USING: image kernel parser sequences io ;
[
    "/library/ui/gadgets.factor"
    "/library/ui/hierarchy.factor"
    "/library/ui/paint.factor"
    "/library/ui/fonts.factor"
    "/library/ui/text.factor"
    "/library/ui/gestures.factor"
    "/library/ui/layouts.factor"
    "/library/ui/borders.factor"
    "/library/ui/frames.factor"
    "/library/ui/world.factor"
    "/library/ui/hand.factor"
    "/library/ui/labels.factor"
    "/library/ui/buttons.factor"
    "/library/ui/line-editor.factor"
    "/library/ui/events.factor"
    "/library/ui/scrolling.factor"
    "/library/ui/editors.factor"
    "/library/ui/menus.factor"
    "/library/ui/splitters.factor"
    "/library/ui/incremental.factor"
    "/library/ui/panes.factor"
    "/library/ui/presentations.factor"
    "/library/ui/books.factor"
    "/library/ui/ui.factor"
] [
    dup print
    bootstrapping? get
    [ parse-resource % ] [ run-resource ] ifte
] each
