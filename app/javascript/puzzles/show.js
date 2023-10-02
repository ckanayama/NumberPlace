window.addEventListener('load', function() {
  var puzzle_columns = document.getElementsByClassName("puzzle_column");
  for(var i = 0; i < puzzle_columns.length; i++){
    puzzle_columns[i].addEventListener('mouseover', function() {
      this.classList.add("puzzle_column_hover");
      let index = this.id.replace("index_", "");
      selectIndexes(index).forEach(function(i) {
        puzzle_columns[i].classList.add("puzzle_column_hover");
      });
    });

    puzzle_columns[i].addEventListener('mouseout', function() {
      this.classList.remove("puzzle_column_hover");
      let index = this.id.replace("index_", "");
      selectIndexes(index).forEach(function(i) {
        puzzle_columns[i].classList.remove("puzzle_column_hover");
      });
    });
	}

  function selectIndexes(index) {
    let indexes = [];

    // 0　まで
    while (index > 0) {
      index-=9;
      if (index < 0) { break; }
      indexes.push(index);
    }

    // 81まで
    while (index < 81) {
      // NOTE: 09, 099 になってしまうため
      if (index == 0) {
        index = 9;
        indexes.push(index);
      }
      index+=9;
      if (index > 81) { break; }
      indexes.push(index);
    }

    return indexes;
  }  
});
