class TroubleSort {

    int[] integers;

    TroubleSort(int[] integers) {
        super();
        this.integers = integers;
    }

    String output() {
        while (this.sort()) ;
        int unsortedFirstIndex = this.unsortedFirstIndex();
        if (unsortedFirstIndex< 0) {
            return "OK";
        } else{
            return "" + unsortedFirstIndex;
        }
    }

    Boolean sort() {
        Boolean isSwapped = false;
        for (int i = 0; i < integers.length - 2; i++) {
            if (this.integers[i] > this.integers[i + 2]) {
                int temp = this.integers[i];
                this.integers[i] = this.integers[i + 2];
                this.integers[i + 2] = temp;
                isSwapped = true;
            }
        }
        return isSwapped;
    }

    int unsortedFirstIndex() {
        for (int i = 0; i < integers.length - 1; i++) {
            if (this.integers[i] > this.integers[i + 1]) {
                return i;
            }
        }
        return -1;
    }
}
