public class NoughtsAndCrosses {

	private int aa;
	private int ab;
	private int ac;
	private int ba;
	private int bb;
	private int bc;
	private int ca;
	private int cb;
	private int cc;

	public NoughtsAndCrosses(int[][] board) {
		this.aa = board[0][0];
		this.ab = board[0][1];
		this.ac = board[0][2];
		this.ba = board[1][0];
		this.bb = board[1][1];
		this.bc = board[1][2];
		this.ca = board[2][0];
		this.cb = board[2][1];
		this.cc = board[2][2];
	}

	public boolean isDraw() {
		return whoWon() == 0;
	}

	public int whoWon() {
		int a = 0;
		if (((aa == ab && aa == ac) && (aa == 1))
				|| ((ba == bb && ba == bc) && (ba == 1))
				|| ((ca == cb && ca == cc) && (ca == 1))
				|| ((aa == ba && aa == ca) && (aa == 1))
				|| ((ab == bb && ab == cb) && (ab == 1))
				|| ((ac == bc && ac == cc) && (ac == 1))
				|| ((aa == bb && aa == cc) && (aa == 1))
				|| ((ac == bb && ac == ca) && (ac == 1))) {
			a = 1;
		}
		if (((aa == ab && aa == ac) && (aa == 2))
				|| ((ba == bb && ba == bc) && (ba == 2))
				|| ((ca == cb && ca == cc) && (ca == 2))
				|| ((aa == ba && aa == ca) && (aa == 2))
				|| ((ab == bb && ab == cb) && (ab == 2))
				|| ((ac == bc && ac == cc) && (ac == 2))
				|| ((aa == bb && aa == cc) && (aa == 2))
				|| ((ac == bb && ac == ca) && (ac == 2))) {
			a = 2;
		}
		return a;
	}
}
