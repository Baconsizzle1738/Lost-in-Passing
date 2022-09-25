var enemies = ["Pawn", "Knight", "Bishop", "Rook", "Queen"];



func isEnemy(name):
	for e in enemies:
		if e == name:
			return true;
	return false;
