# This program is free software. It comes without any warranty, to
# the extent permitted by applicable law. You can redistribute it
# and/or modify it under the terms of the Do What You Want To Public
# License, Version 3, as published by Devin Weaver. See
# http://tritarget.org/wywtpl/COPYING for more details.
Utils =
  getRandomInt: (min,max) ->
    Math.floor(Math.random() * (max - min + 1)) + min

module.exports = Utils
