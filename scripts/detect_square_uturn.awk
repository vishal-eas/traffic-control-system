function isroad(x) {
  return x ~ /^[HV]\[[0-9]+,[0-9]+\][FB] slot=[0-9]+$/
}

function roadKey(x, t) {
  t = x
  sub(/ slot=.*/, "", t)
  sub(/[FB]$/, "", t)
  return t
}

function roadDir(x, t) {
  t = x
  sub(/ slot=.*/, "", t)
  if (t ~ /F$/) return "F"
  if (t ~ /B$/) return "B"
  return "?"
}

/^T=/ {
  t = $1
  sub("T=", "", t)
  sub(":", "", t)

  line = $0
  sub(/^T=[0-9]+: V3: /, "", line)
  split(line, p2, " V2: ")
  s3[t] = p2[1]
  split(p2[2], p1, " V1: ")
  s2[t] = p1[1]
  s1[t] = p1[2]

  if (t > max_t) max_t = t
}

function getS(v, i) {
  if (v == 1) return s1[i]
  if (v == 2) return s2[i]
  return s3[i]
}

END {
  found = 0
  for (v = 1; v <= 3; v++) {
    for (i = 1; i < max_t; i++) {
      cur = getS(v, i)
      prev = getS(v, i - 1)
      if (cur ~ /^[ABCD]$/ && prev != cur) {
        inRoad = ""
        outRoad = ""

        for (j = i - 1; j >= 0; j--) {
          st = getS(v, j)
          if (isroad(st)) {
            inRoad = st
            break
          }
        }

        for (k = i + 1; k <= max_t; k++) {
          st2 = getS(v, k)
          if (isroad(st2)) {
            outRoad = st2
            break
          }
        }

        if (inRoad != "" && outRoad != "" && roadKey(inRoad) == roadKey(outRoad) && roadDir(inRoad) != roadDir(outRoad)) {
          print "UTURN-LIKE V" v " at T=" i " square=" cur " in=" inRoad " out=" outRoad
          found = 1
        }
      }
    }
  }

  if (!found) {
    print "NO_UTURN_LIKE_SQUARE_REVERSALS"
  }
}
