;original code created by Marley Alford at Harvard University in July 2016.

;initial set-up
extensions [palette]
breed[seeds seed]
breed[seekers seeker]

seeds-own[]
patches-own[
  gradient-val
  obstacle-val
  ]
seekers-own[]

to setup
  clear-all   ;important!!
  reset-ticks  ;important!!
  let color-val get-color  ;convert the chosen gradient color to numerical value

  create-seeds num-seeds [
    set shape "kilobot"
    set size 1
    set color white
    ifelse num-seeds > 1   ;if there are more than one seeds, put them in random positions
      [setxy random-xcor random-ycor]
      [ifelse num-obstacles > 0  ;position also depends on if there are obstacles or not
        [setxy 32 16]
        [setxy (world-height - 1) (world-width - 1)]
      ]
    ask patch-here [
      set gradient-val 0
      set pcolor white
      ]
  ]

  create-seekers num-seekers [
    set size 1
    set shape "kilobot"
    ifelse num-seekers > 1  ;if there are more than one seekers, put them in random positions
    [setxy random-xcor random-ycor]
    [ifelse num-obstacles > 0  ;position also depends on if there are obstacles or not
      [setxy 0 16]
      [setxy 0 0]
    ]
    pen-down
    set color yellow
    set pen-size 3
  ]

  ;;;GRADIENT STUFF
  ask patches[
    set gradient-val 1000
    set obstacle-val 1000
    if any? seeds-here [
      set gradient-val 0
    ]
  ]

  ;;;OBSTACLE STUFF
  if num-obstacles > 0[  ;if user chose to have an obstacle make obstacle
    let interval floor (world-width / (num-obstacles + 1))  ;decides interval that obstacles will be places
    let start-val interval
    let it-list n-values num-obstacles [? + 1]  ;create a list of numbers from 1 - num-obstacles to iterate through
    show word "The list is " it-list
    let every-other true  ;because we want alternating top and bottom walls
    foreach it-list [
      ;show ?
      ifelse every-other = true [
        make-bottom-wall start-val
        set every-other false
      ]
      [make-top-wall start-val
        set every-other true
      ]
      set start-val start-val + interval
    ]
  ]

  ;sets up values
  set-up-gradient

  ;sets up colors
  ask patches[
   set pcolor palette:scale-scheme "Sequential" get-color 9 gradient-val 0 (world-width * 2)
  ]

  ;sets up gradient value labels on each patch
  ask patches[
    if obstacle-val != 0 [
      set plabel gradient-val
    ]
  ]

end

;this is where the action happens
to go
  ask seekers [  ;each step seeker is choosing minimum gradient-val patch
    let p min-grad-patch
    let a [pxcor] of p
    let b [pycor] of p
    ;if a b not xycor of seed
    if [gradient-val] of patch-here != 0  ;stop when you get to seed
      [setxy a b]
  ]
end


;;;METHODS
to-report min-grad-val ;finds and reports minimum gradient value among neighbor patches
  report min [gradient-val] of neighbors4
end

to-report min-obs-val ;finds and reports minimum gradient value among neighbor patches
  report min [obstacle-val] of neighbors4
end

to-report min-grad-patch ;finds and reports neighbor with minimum gradient value
  let q min-grad-val
  let p patch-here
  let grad-list []
  let p-list sort neighbors4
  foreach p-list [if [gradient-val] of ? = q  ;if a patch has the minimum gradient value, put it in list
    [set grad-list fput ? grad-list]  ;set p to the minimum gradient-value patch
    ]
  report one-of grad-list  ;picks a random minimum gradient-val patch
end

to-report get-color  ;translates slider color value into numbers that functions can use
  ;we automatically go with red
  let c "Reds"
  ifelse gradient-color = "Orange"
    [set c "Oranges"]
    [ifelse gradient-color = "Green"
        [set c "Greens"]
        [ifelse gradient-color = "Blue"
            [set c "Blues"]
            [if gradient-color = "Pink"
                [set c "Pinks"]
            ]
        ]
    ]
    report c
end

to make-bottom-wall [x]  ;makes a wall that starts from y = 0
  let len 0
  let y 0
  while [len + 1 <= obstacle-height][
    build x y
    set len len + 1
    set y y + 1
    ]
end

to make-top-wall [x]  ;makes a wall that starts from y = 32
  output-write x
  let len 0
  let y 32
  while [len + 1 <= obstacle-height][
    build x y
    set len len + 1
    set y y - 1
    ]
end

to build [x y]  ;builds each unit of a wall
  let color-val get-color
  ask patch x y [
    set pcolor black
    set gradient-val 255
    set obstacle-val 0
    ]
end

to set-up-gradient  ;creates the gradient
  let change false
  loop[
    set change false
      ask patches[
        if gradient-val != 0 and obstacle-val != 0[  ;any patch that isn't the seed
          let m min-grad-val + 1
          if gradient-val != m [
            set gradient-val m
            set change true;
          ]
        ]
      ]
      if change = false [stop]
    ]
end

to set-up-obstacle-gradient  ;creates the gradient from obstacles
  let change false
  loop[
    set change false
      ask patches[
        if obstacle-val != 0 [  ;any patch that isn't the seed
          let m min-obs-val + 1
          if obstacle-val != m [
            set obstacle-val m
            set change true;
          ]
        ]
      ]
      if change = false [stop]
    ]
end
