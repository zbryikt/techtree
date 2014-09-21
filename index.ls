angular.module \main, <[]>
  ..controller \main, <[$scope]> ++ ($scope) ->
    console.log \ok
    d3.json \techtree.json, (data) ->
      m = 100
      cluster = d3.layout.cluster!size [1200 - 2 * m,  1200 - 2 * m]
      nodes = cluster.nodes data
      links = cluster.links nodes
      console.log nodes
      diag = d3.svg.diagonal!

      d3.select '#svg g' .selectAll \path .data links
        ..exit!remove!
        ..enter!append \path
      d3.select '#svg g' .selectAll \path .attr do
        d: -> diag it
        stroke: \#999
        "stroke-width": \3px
        fill: \none

      d3.select '#svg g' .selectAll \rect .data nodes
        ..exit!remove!
        ..enter!append \rect
      d3.select '#svg g' .selectAll \rect 
        ..attr do
          x: -> it.x - 40
          y: -> it.y - 40
          width: 80
          height: 80
          fill: -> "url(\#p#{it.id})"
        ..style cursor: \pointer
        ..on \mouseover (d)->
          d3.select(@)transition!duration 500 .attr do
            x: -> d.x - 80
            y: -> d.y - 80
            width: 160
            height: 160
        ..on \mouseout (d)->
          d3.select(@)transition!duration 500 .attr do
            x: -> d.x - 40
            y: -> d.y - 40
            width: 80
            height: 80

