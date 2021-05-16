class President {

    final static char SHOOT = 'S';
    final static char CHARGE = 'C';

    int shield;
    char[] instructions;

    President(int shield, String instructions) {
        super();
        this.shield = shield;
        this.instructions = instructions.toCharArray();
    }

    String output() {
        if (this.isPossible()) {
            return "" + this.numberOfHacksNeeded();
        } else {
            return "IMPOSSIBLE";
        }
    }

    Boolean isPossible() {
        int numberOfShoot = 0;
        for (int i = 0; i < this.instructions.length; i++) {
            if (this.instructions[i] == SHOOT) {
                numberOfShoot += 1;
            }
        }
        return this.shield >= numberOfShoot;
    }

    int numberOfHacksNeeded() {
        int numberOfHack = 0;
        while (this.isHackNeeded()) {
            this.hack();
            numberOfHack += 1;
        }
        return numberOfHack;
    }

    void hack() {
        for (int i = this.instructions.length - 2; i >= 0; i--) {
            char instruction = this.instructions[i];
            char nextInstruction = this.instructions[i + 1];
            if (instruction == CHARGE && nextInstruction == SHOOT) {
                this.instructions[i] = SHOOT;
                this.instructions[i + 1] = CHARGE;
                return;
            }
        }
    }

    Boolean isHackNeeded() {
        int damagePerShoot = 1;
        int remainingShield = this.shield;
        for (int i = 0; i < this.instructions.length; i++) {
            char instruction = this.instructions[i];
            if (instruction == SHOOT) {
                remainingShield -= damagePerShoot;
                if (remainingShield < 0) {
                    return true;
                }
            } else if (instruction == CHARGE) {
                damagePerShoot *= 2;
            }
        }
        return remainingShield < 0;
    }
}
