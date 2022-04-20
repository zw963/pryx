trap(:QUIT) {
  t = Thread.list.first
  puts '#' * 90
  p t
  puts t.backtrace
  puts '#' * 90
}
