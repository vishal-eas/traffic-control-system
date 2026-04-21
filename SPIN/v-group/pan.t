#ifdef PEG
struct T_SRC {
	char *fl; int ln;
} T_SRC[NTRANS];

void
tr_2_src(int m, char *file, int ln)
{	T_SRC[m].fl = file;
	T_SRC[m].ln = ln;
}

void
putpeg(int n, int m)
{	printf("%5d	trans %4d ", m, n);
	printf("%s:%d\n",
		T_SRC[n].fl, T_SRC[n].ln);
}
#endif

void
settable(void)
{	Trans *T;
	Trans *settr(int, int, int, int, int, char *, int, int, int);

	trans = (Trans ***) emalloc(14*sizeof(Trans **));

	/* proctype 12: valid_light_topology */

	trans[12] = (Trans **) emalloc(11*sizeof(Trans *));

	trans[12][7]	= settr(1058,0,6,1,0,".(goto)", 0, 2, 0);
	T = trans[12][6] = settr(1057,0,0,0,0,"DO", 0, 2, 0);
	T = T->nxt	= settr(1057,0,3,0,0,"DO", 0, 2, 0);
	    T->nxt	= settr(1057,0,4,0,0,"DO", 0, 2, 0);
	T = trans[ 12][3] = settr(1054,2,0,0,0,"ATOMIC", 1, 2, 0);
	T->nxt	= settr(1054,2,1,0,0,"ATOMIC", 1, 2, 0);
	trans[12][1]	= settr(1052,0,6,3,3,"(!((!(model_initialized)||(((((((((((((((((((((((((((((((((((!(light_enabled[((0*4)+0)])&&light_enabled[((0*4)+1)])&&light_enabled[((0*4)+2)])&&light_enabled[((0*4)+3)])&&!(light_enabled[((1*4)+0)]))&&light_enabled[((1*4)+1)])&&light_enabled[((1*4)+2)])&&light_enabled[((1*4)+3)])&&!(light_enabled[((2*4)+0)]))&&!(light_enabled[((2*4)+1)]))&&light_enabled[((2*4)+2)])&&light_enabled[((2*4)+3)])&&light_enabled[((3*4)+0)])&&light_enabled[((3*4)+1)])&&light_enabled[((3*4)+2)])&&!(light_enabled[((3*4)+3)]))&&light_enabled[((4*4)+0)])&&light_enabled[((4*4)+1)])&&light_enabled[((4*4)+2)])&&light_enabled[((4*4)+3)])&&light_enabled[((5*4)+0)])&&!(light_enabled[((5*4)+1)]))&&light_enabled[((5*4)+2)])&&light_enabled[((5*4)+3)])&&light_enabled[((6*4)+0)])&&light_enabled[((6*4)+1)])&&!(light_enabled[((6*4)+2)]))&&!(light_enabled[((6*4)+3)]))&&light_enabled[((7*4)+0)])&&light_enabled[((7*4)+1)])&&!(light_enabled[((7*4)+2)]))&&light_enabled[((7*4)+3)])&&light_enabled[((8*4)+0)])&&!(light_enabled[((8*4)+1)]))&&!(light_enabled[((8*4)+2)]))&&light_enabled[((8*4)+3)]))))", 1, 2, 0); /* m: 2 -> 6,0 */
	reached12[2] = 1;
	trans[12][2]	= settr(0,0,0,0,0,"assert(!(!((!(model_initialized)||(((((((((((((((((((((((((((((((((((!(light_enabled[((0*4)+0)])&&light_enabled[((0*4)+1)])&&light_enabled[((0*4)+2)])&&light_enabled[((0*4)+3)])&&!(light_enabled[((1*4)+0)]))&&light_enabled[((1*4)+1)])&&light_enabled[((1*4)+2)])&&light_enabled[((1*4)+3)])&&!(light_enabled[((2*4)+0)]))&&!(light_enabled[((2*4)+1)]))&&light_enabled[((2*4)+2)])&&light_enabled[((2*4)+3)])&&light_enabled[((3*4)+0)])&&light_enabled[((3*4)+1)])&&light_enabled[((3*4)+2)])&&!(light_enabled[((3*4)+3)]))&&light_enabled[((4*4)+0)])&&light_enabled[((4*4)+1)])&&light_enabled[((4*4)+2)])&&light_enabled[((4*4)+3)])&&light_enabled[((5*4)+0)])&&!(light_enabled[((5*4)+1)]))&&light_enabled[((5*4)+2)])&&light_enabled[((5*4)+3)])&&light_enabled[((6*4)+0)])&&light_enabled[((6*4)+1)])&&!(light_enabled[((6*4)+2)]))&&!(light_enabled[((6*4)+3)]))&&light_enabled[((7*4)+0)])&&light_enabled[((7*4)+1)])&&!(light_enabled[((7*4)+2)]))&&light_enabled[((7*4)+3)])&&light_enabled[((8*4)+0)])&&!(light_enabled[((8*4)+1)]))&&!(light_enabled[((8*4)+2)]))&&light_enabled[((8*4)+3)])))))",0,0,0);
	trans[12][4]	= settr(1055,0,6,1,0,"(1)", 0, 2, 0);
	trans[12][5]	= settr(1056,0,6,1,0,"goto T0_init", 0, 2, 0);
	trans[12][8]	= settr(1059,0,9,1,0,"break", 0, 2, 0);
	trans[12][9]	= settr(1060,0,10,1,0,"(1)", 0, 2, 0);
	trans[12][10]	= settr(1061,0,0,4,4,"-end-", 0, 3500, 0);

	/* proctype 11: mutual_exclusion_lights */

	trans[11] = (Trans **) emalloc(11*sizeof(Trans *));

	trans[11][7]	= settr(1048,0,6,1,0,".(goto)", 0, 2, 0);
	T = trans[11][6] = settr(1047,0,0,0,0,"DO", 0, 2, 0);
	T = T->nxt	= settr(1047,0,3,0,0,"DO", 0, 2, 0);
	    T->nxt	= settr(1047,0,4,0,0,"DO", 0, 2, 0);
	T = trans[ 11][3] = settr(1044,2,0,0,0,"ATOMIC", 1, 2, 0);
	T->nxt	= settr(1044,2,1,0,0,"ATOMIC", 1, 2, 0);
	trans[11][1]	= settr(1042,0,6,5,5,"(!((!(model_initialized)||((((((((((light_green[0]<=3)&&light_enabled[((0*4)+light_green[0])])&&((light_green[1]<=3)&&light_enabled[((1*4)+light_green[1])]))&&((light_green[2]<=3)&&light_enabled[((2*4)+light_green[2])]))&&((light_green[3]<=3)&&light_enabled[((3*4)+light_green[3])]))&&((light_green[4]<=3)&&light_enabled[((4*4)+light_green[4])]))&&((light_green[5]<=3)&&light_enabled[((5*4)+light_green[5])]))&&((light_green[6]<=3)&&light_enabled[((6*4)+light_green[6])]))&&((light_green[7]<=3)&&light_enabled[((7*4)+light_green[7])]))&&((light_green[8]<=3)&&light_enabled[((8*4)+light_green[8])])))))", 1, 2, 0); /* m: 2 -> 6,0 */
	reached11[2] = 1;
	trans[11][2]	= settr(0,0,0,0,0,"assert(!(!((!(model_initialized)||((((((((((light_green[0]<=3)&&light_enabled[((0*4)+light_green[0])])&&((light_green[1]<=3)&&light_enabled[((1*4)+light_green[1])]))&&((light_green[2]<=3)&&light_enabled[((2*4)+light_green[2])]))&&((light_green[3]<=3)&&light_enabled[((3*4)+light_green[3])]))&&((light_green[4]<=3)&&light_enabled[((4*4)+light_green[4])]))&&((light_green[5]<=3)&&light_enabled[((5*4)+light_green[5])]))&&((light_green[6]<=3)&&light_enabled[((6*4)+light_green[6])]))&&((light_green[7]<=3)&&light_enabled[((7*4)+light_green[7])]))&&((light_green[8]<=3)&&light_enabled[((8*4)+light_green[8])]))))))",0,0,0);
	trans[11][4]	= settr(1045,0,6,1,0,"(1)", 0, 2, 0);
	trans[11][5]	= settr(1046,0,6,1,0,"goto T0_init", 0, 2, 0);
	trans[11][8]	= settr(1049,0,9,1,0,"break", 0, 2, 0);
	trans[11][9]	= settr(1050,0,10,1,0,"(1)", 0, 2, 0);
	trans[11][10]	= settr(1051,0,0,6,6,"-end-", 0, 3500, 0);

	/* proctype 10: fair_green_bounded */

	trans[10] = (Trans **) emalloc(11*sizeof(Trans *));

	trans[10][7]	= settr(1038,0,6,1,0,".(goto)", 0, 2, 0);
	T = trans[10][6] = settr(1037,0,0,0,0,"DO", 0, 2, 0);
	T = T->nxt	= settr(1037,0,3,0,0,"DO", 0, 2, 0);
	    T->nxt	= settr(1037,0,4,0,0,"DO", 0, 2, 0);
	T = trans[ 10][3] = settr(1034,2,0,0,0,"ATOMIC", 1, 2, 0);
	T->nxt	= settr(1034,2,1,0,0,"ATOMIC", 1, 2, 0);
	trans[10][1]	= settr(1032,0,6,7,7,"(!((!(model_initialized)||(((((((((((((((((((((((((red_streak[((0*4)+1)]<=5)&&(red_streak[((0*4)+2)]<=5))&&(red_streak[((0*4)+3)]<=5))&&(red_streak[((1*4)+1)]<=5))&&(red_streak[((1*4)+2)]<=5))&&(red_streak[((1*4)+3)]<=5))&&(red_streak[((2*4)+2)]<=4))&&(red_streak[((2*4)+3)]<=4))&&(red_streak[((3*4)+0)]<=5))&&(red_streak[((3*4)+1)]<=5))&&(red_streak[((3*4)+2)]<=5))&&(red_streak[((4*4)+0)]<=6))&&(red_streak[((4*4)+1)]<=6))&&(red_streak[((4*4)+2)]<=6))&&(red_streak[((4*4)+3)]<=6))&&(red_streak[((5*4)+0)]<=5))&&(red_streak[((5*4)+2)]<=5))&&(red_streak[((5*4)+3)]<=5))&&(red_streak[((6*4)+0)]<=4))&&(red_streak[((6*4)+1)]<=4))&&(red_streak[((7*4)+0)]<=5))&&(red_streak[((7*4)+1)]<=5))&&(red_streak[((7*4)+3)]<=5))&&(red_streak[((8*4)+0)]<=4))&&(red_streak[((8*4)+3)]<=4)))))", 1, 2, 0); /* m: 2 -> 6,0 */
	reached10[2] = 1;
	trans[10][2]	= settr(0,0,0,0,0,"assert(!(!((!(model_initialized)||(((((((((((((((((((((((((red_streak[((0*4)+1)]<=5)&&(red_streak[((0*4)+2)]<=5))&&(red_streak[((0*4)+3)]<=5))&&(red_streak[((1*4)+1)]<=5))&&(red_streak[((1*4)+2)]<=5))&&(red_streak[((1*4)+3)]<=5))&&(red_streak[((2*4)+2)]<=4))&&(red_streak[((2*4)+3)]<=4))&&(red_streak[((3*4)+0)]<=5))&&(red_streak[((3*4)+1)]<=5))&&(red_streak[((3*4)+2)]<=5))&&(red_streak[((4*4)+0)]<=6))&&(red_streak[((4*4)+1)]<=6))&&(red_streak[((4*4)+2)]<=6))&&(red_streak[((4*4)+3)]<=6))&&(red_streak[((5*4)+0)]<=5))&&(red_streak[((5*4)+2)]<=5))&&(red_streak[((5*4)+3)]<=5))&&(red_streak[((6*4)+0)]<=4))&&(red_streak[((6*4)+1)]<=4))&&(red_streak[((7*4)+0)]<=5))&&(red_streak[((7*4)+1)]<=5))&&(red_streak[((7*4)+3)]<=5))&&(red_streak[((8*4)+0)]<=4))&&(red_streak[((8*4)+3)]<=4))))))",0,0,0);
	trans[10][4]	= settr(1035,0,6,1,0,"(1)", 0, 2, 0);
	trans[10][5]	= settr(1036,0,6,1,0,"goto T0_init", 0, 2, 0);
	trans[10][8]	= settr(1039,0,9,1,0,"break", 0, 2, 0);
	trans[10][9]	= settr(1040,0,10,1,0,"(1)", 0, 2, 0);
	trans[10][10]	= settr(1041,0,0,8,8,"-end-", 0, 3500, 0);

	/* proctype 9: eventual_green_bounded */

	trans[9] = (Trans **) emalloc(11*sizeof(Trans *));

	trans[9][7]	= settr(1028,0,6,1,0,".(goto)", 0, 2, 0);
	T = trans[9][6] = settr(1027,0,0,0,0,"DO", 0, 2, 0);
	T = T->nxt	= settr(1027,0,3,0,0,"DO", 0, 2, 0);
	    T->nxt	= settr(1027,0,4,0,0,"DO", 0, 2, 0);
	T = trans[ 9][3] = settr(1024,2,0,0,0,"ATOMIC", 1, 2, 0);
	T->nxt	= settr(1024,2,1,0,0,"ATOMIC", 1, 2, 0);
	trans[9][1]	= settr(1022,0,6,9,9,"(!((!(model_initialized)||(((((((((((((((((((((((((red_streak[((0*4)+1)]<=5)&&(red_streak[((0*4)+2)]<=5))&&(red_streak[((0*4)+3)]<=5))&&(red_streak[((1*4)+1)]<=5))&&(red_streak[((1*4)+2)]<=5))&&(red_streak[((1*4)+3)]<=5))&&(red_streak[((2*4)+2)]<=4))&&(red_streak[((2*4)+3)]<=4))&&(red_streak[((3*4)+0)]<=5))&&(red_streak[((3*4)+1)]<=5))&&(red_streak[((3*4)+2)]<=5))&&(red_streak[((4*4)+0)]<=6))&&(red_streak[((4*4)+1)]<=6))&&(red_streak[((4*4)+2)]<=6))&&(red_streak[((4*4)+3)]<=6))&&(red_streak[((5*4)+0)]<=5))&&(red_streak[((5*4)+2)]<=5))&&(red_streak[((5*4)+3)]<=5))&&(red_streak[((6*4)+0)]<=4))&&(red_streak[((6*4)+1)]<=4))&&(red_streak[((7*4)+0)]<=5))&&(red_streak[((7*4)+1)]<=5))&&(red_streak[((7*4)+3)]<=5))&&(red_streak[((8*4)+0)]<=4))&&(red_streak[((8*4)+3)]<=4)))))", 1, 2, 0); /* m: 2 -> 6,0 */
	reached9[2] = 1;
	trans[9][2]	= settr(0,0,0,0,0,"assert(!(!((!(model_initialized)||(((((((((((((((((((((((((red_streak[((0*4)+1)]<=5)&&(red_streak[((0*4)+2)]<=5))&&(red_streak[((0*4)+3)]<=5))&&(red_streak[((1*4)+1)]<=5))&&(red_streak[((1*4)+2)]<=5))&&(red_streak[((1*4)+3)]<=5))&&(red_streak[((2*4)+2)]<=4))&&(red_streak[((2*4)+3)]<=4))&&(red_streak[((3*4)+0)]<=5))&&(red_streak[((3*4)+1)]<=5))&&(red_streak[((3*4)+2)]<=5))&&(red_streak[((4*4)+0)]<=6))&&(red_streak[((4*4)+1)]<=6))&&(red_streak[((4*4)+2)]<=6))&&(red_streak[((4*4)+3)]<=6))&&(red_streak[((5*4)+0)]<=5))&&(red_streak[((5*4)+2)]<=5))&&(red_streak[((5*4)+3)]<=5))&&(red_streak[((6*4)+0)]<=4))&&(red_streak[((6*4)+1)]<=4))&&(red_streak[((7*4)+0)]<=5))&&(red_streak[((7*4)+1)]<=5))&&(red_streak[((7*4)+3)]<=5))&&(red_streak[((8*4)+0)]<=4))&&(red_streak[((8*4)+3)]<=4))))))",0,0,0);
	trans[9][4]	= settr(1025,0,6,1,0,"(1)", 0, 2, 0);
	trans[9][5]	= settr(1026,0,6,1,0,"goto T0_init", 0, 2, 0);
	trans[9][8]	= settr(1029,0,9,1,0,"break", 0, 2, 0);
	trans[9][9]	= settr(1030,0,10,1,0,"(1)", 0, 2, 0);
	trans[9][10]	= settr(1031,0,0,10,10,"-end-", 0, 3500, 0);

	/* proctype 8: tour_closure */

	trans[8] = (Trans **) emalloc(7*sizeof(Trans *));

	trans[8][4]	= settr(1019,0,3,1,0,".(goto)", 0, 2, 0);
	T = trans[8][3] = settr(1018,0,0,0,0,"DO", 0, 2, 0);
	    T->nxt	= settr(1018,0,1,0,0,"DO", 0, 2, 0);
	trans[8][1]	= settr(1016,0,3,11,0,"(!((returned_A[0]&&returned_A[1])))", 1, 2, 0);
	trans[8][2]	= settr(1017,0,3,1,0,"goto T0_init", 0, 2, 0);
	trans[8][5]	= settr(1020,0,6,1,0,"break", 0, 2, 0);
	trans[8][6]	= settr(1021,0,0,12,12,"-end-", 0, 3500, 0);

	/* proctype 7: visit_all_bcd */

	trans[7] = (Trans **) emalloc(7*sizeof(Trans *));

	trans[7][4]	= settr(1013,0,3,1,0,".(goto)", 0, 2, 0);
	T = trans[7][3] = settr(1012,0,0,0,0,"DO", 0, 2, 0);
	    T->nxt	= settr(1012,0,1,0,0,"DO", 0, 2, 0);
	trans[7][1]	= settr(1010,0,3,13,0,"(!((((((visited_B[0]&&visited_C[0])&&visited_D[0])&&visited_B[1])&&visited_C[1])&&visited_D[1])))", 1, 2, 0);
	trans[7][2]	= settr(1011,0,3,1,0,"goto T0_init", 0, 2, 0);
	trans[7][5]	= settr(1014,0,6,1,0,"break", 0, 2, 0);
	trans[7][6]	= settr(1015,0,0,14,14,"-end-", 0, 3500, 0);

	/* proctype 6: no_uturn */

	trans[6] = (Trans **) emalloc(11*sizeof(Trans *));

	trans[6][7]	= settr(1006,0,6,1,0,".(goto)", 0, 2, 0);
	T = trans[6][6] = settr(1005,0,0,0,0,"DO", 0, 2, 0);
	T = T->nxt	= settr(1005,0,3,0,0,"DO", 0, 2, 0);
	    T->nxt	= settr(1005,0,4,0,0,"DO", 0, 2, 0);
	T = trans[ 6][3] = settr(1002,2,0,0,0,"ATOMIC", 1, 2, 0);
	T->nxt	= settr(1002,2,1,0,0,"ATOMIC", 1, 2, 0);
	trans[6][1]	= settr(1000,0,6,15,15,"(!(!(uturn_violation)))", 1, 2, 0); /* m: 2 -> 6,0 */
	reached6[2] = 1;
	trans[6][2]	= settr(0,0,0,0,0,"assert(!(!(!(uturn_violation))))",0,0,0);
	trans[6][4]	= settr(1003,0,6,1,0,"(1)", 0, 2, 0);
	trans[6][5]	= settr(1004,0,6,1,0,"goto T0_init", 0, 2, 0);
	trans[6][8]	= settr(1007,0,9,1,0,"break", 0, 2, 0);
	trans[6][9]	= settr(1008,0,10,1,0,"(1)", 0, 2, 0);
	trans[6][10]	= settr(1009,0,0,16,16,"-end-", 0, 3500, 0);

	/* proctype 5: no_opposite_direction */

	trans[5] = (Trans **) emalloc(11*sizeof(Trans *));

	trans[5][7]	= settr(996,0,6,1,0,".(goto)", 0, 2, 0);
	T = trans[5][6] = settr(995,0,0,0,0,"DO", 0, 2, 0);
	T = T->nxt	= settr(995,0,3,0,0,"DO", 0, 2, 0);
	    T->nxt	= settr(995,0,4,0,0,"DO", 0, 2, 0);
	T = trans[ 5][3] = settr(992,2,0,0,0,"ATOMIC", 1, 2, 0);
	T->nxt	= settr(992,2,1,0,0,"ATOMIC", 1, 2, 0);
	trans[5][1]	= settr(990,0,6,17,17,"(!(!(opposite_direction_violation)))", 1, 2, 0); /* m: 2 -> 6,0 */
	reached5[2] = 1;
	trans[5][2]	= settr(0,0,0,0,0,"assert(!(!(!(opposite_direction_violation))))",0,0,0);
	trans[5][4]	= settr(993,0,6,1,0,"(1)", 0, 2, 0);
	trans[5][5]	= settr(994,0,6,1,0,"goto T0_init", 0, 2, 0);
	trans[5][8]	= settr(997,0,9,1,0,"break", 0, 2, 0);
	trans[5][9]	= settr(998,0,10,1,0,"(1)", 0, 2, 0);
	trans[5][10]	= settr(999,0,0,18,18,"-end-", 0, 3500, 0);

	/* proctype 4: no_red_violation */

	trans[4] = (Trans **) emalloc(11*sizeof(Trans *));

	trans[4][7]	= settr(986,0,6,1,0,".(goto)", 0, 2, 0);
	T = trans[4][6] = settr(985,0,0,0,0,"DO", 0, 2, 0);
	T = T->nxt	= settr(985,0,3,0,0,"DO", 0, 2, 0);
	    T->nxt	= settr(985,0,4,0,0,"DO", 0, 2, 0);
	T = trans[ 4][3] = settr(982,2,0,0,0,"ATOMIC", 1, 2, 0);
	T->nxt	= settr(982,2,1,0,0,"ATOMIC", 1, 2, 0);
	trans[4][1]	= settr(980,0,6,19,19,"(!(!(red_violation)))", 1, 2, 0); /* m: 2 -> 6,0 */
	reached4[2] = 1;
	trans[4][2]	= settr(0,0,0,0,0,"assert(!(!(!(red_violation))))",0,0,0);
	trans[4][4]	= settr(983,0,6,1,0,"(1)", 0, 2, 0);
	trans[4][5]	= settr(984,0,6,1,0,"goto T0_init", 0, 2, 0);
	trans[4][8]	= settr(987,0,9,1,0,"break", 0, 2, 0);
	trans[4][9]	= settr(988,0,10,1,0,"(1)", 0, 2, 0);
	trans[4][10]	= settr(989,0,0,20,20,"-end-", 0, 3500, 0);

	/* proctype 3: no_collision */

	trans[3] = (Trans **) emalloc(11*sizeof(Trans *));

	trans[3][7]	= settr(976,0,6,1,0,".(goto)", 0, 2, 0);
	T = trans[3][6] = settr(975,0,0,0,0,"DO", 0, 2, 0);
	T = T->nxt	= settr(975,0,3,0,0,"DO", 0, 2, 0);
	    T->nxt	= settr(975,0,4,0,0,"DO", 0, 2, 0);
	T = trans[ 3][3] = settr(972,2,0,0,0,"ATOMIC", 1, 2, 0);
	T->nxt	= settr(972,2,1,0,0,"ATOMIC", 1, 2, 0);
	trans[3][1]	= settr(970,0,6,21,21,"(!(!(collision)))", 1, 2, 0); /* m: 2 -> 6,0 */
	reached3[2] = 1;
	trans[3][2]	= settr(0,0,0,0,0,"assert(!(!(!(collision))))",0,0,0);
	trans[3][4]	= settr(973,0,6,1,0,"(1)", 0, 2, 0);
	trans[3][5]	= settr(974,0,6,1,0,"goto T0_init", 0, 2, 0);
	trans[3][8]	= settr(977,0,9,1,0,"break", 0, 2, 0);
	trans[3][9]	= settr(978,0,10,1,0,"(1)", 0, 2, 0);
	trans[3][10]	= settr(979,0,0,22,22,"-end-", 0, 3500, 0);

	/* proctype 2: :init: */

	trans[2] = (Trans **) emalloc(372*sizeof(Trans *));

	T = trans[ 2][84] = settr(682,2,0,0,0,"ATOMIC", 1, 2, 0);
	T->nxt	= settr(682,2,1,0,0,"ATOMIC", 1, 2, 0);
	trans[2][1]	= settr(599,2,7,23,23,"i = 0", 1, 2, 0);
	trans[2][8]	= settr(606,2,7,1,0,".(goto)", 1, 2, 0);
	T = trans[2][7] = settr(605,2,0,0,0,"DO", 1, 2, 0);
	T = T->nxt	= settr(605,2,2,0,0,"DO", 1, 2, 0);
	    T->nxt	= settr(605,2,5,0,0,"DO", 1, 2, 0);
	trans[2][2]	= settr(600,2,7,24,24,"((i<(10*4)))", 1, 2, 0); /* m: 3 -> 7,0 */
	reached2[3] = 1;
	trans[2][3]	= settr(0,0,0,0,0,"light_enabled[i] = 0",0,0,0);
	trans[2][4]	= settr(0,0,0,0,0,"i = (i+1)",0,0,0);
	trans[2][5]	= settr(603,2,52,25,25,"((i>=(10*4)))", 1, 2, 0); /* m: 10 -> 52,0 */
	reached2[10] = 1;
	trans[2][6]	= settr(604,2,10,1,0,"goto :b11", 1, 2, 0); /* m: 10 -> 0,52 */
	reached2[10] = 1;
	trans[2][9]	= settr(607,2,10,1,0,"break", 1, 2, 0);
	trans[2][10]	= settr(608,2,52,26,26,"light_enabled[((0*4)+1)] = 1", 1, 2, 0); /* m: 11 -> 0,52 */
	reached2[11] = 1;
	trans[2][11]	= settr(0,0,0,0,0,"light_enabled[((0*4)+2)] = 1",0,0,0);
	trans[2][12]	= settr(0,0,0,0,0,"light_enabled[((0*4)+3)] = 1",0,0,0);
	trans[2][13]	= settr(0,0,0,0,0,"light_enabled[((1*4)+1)] = 1",0,0,0);
	trans[2][14]	= settr(0,0,0,0,0,"light_enabled[((1*4)+2)] = 1",0,0,0);
	trans[2][15]	= settr(0,0,0,0,0,"light_enabled[((1*4)+3)] = 1",0,0,0);
	trans[2][16]	= settr(0,0,0,0,0,"light_enabled[((2*4)+2)] = 1",0,0,0);
	trans[2][17]	= settr(0,0,0,0,0,"light_enabled[((2*4)+3)] = 1",0,0,0);
	trans[2][18]	= settr(0,0,0,0,0,"light_enabled[((3*4)+0)] = 1",0,0,0);
	trans[2][19]	= settr(0,0,0,0,0,"light_enabled[((3*4)+1)] = 1",0,0,0);
	trans[2][20]	= settr(0,0,0,0,0,"light_enabled[((3*4)+2)] = 1",0,0,0);
	trans[2][21]	= settr(0,0,0,0,0,"light_enabled[((4*4)+0)] = 1",0,0,0);
	trans[2][22]	= settr(0,0,0,0,0,"light_enabled[((4*4)+1)] = 1",0,0,0);
	trans[2][23]	= settr(0,0,0,0,0,"light_enabled[((4*4)+2)] = 1",0,0,0);
	trans[2][24]	= settr(0,0,0,0,0,"light_enabled[((4*4)+3)] = 1",0,0,0);
	trans[2][25]	= settr(0,0,0,0,0,"light_enabled[((5*4)+0)] = 1",0,0,0);
	trans[2][26]	= settr(0,0,0,0,0,"light_enabled[((5*4)+2)] = 1",0,0,0);
	trans[2][27]	= settr(0,0,0,0,0,"light_enabled[((5*4)+3)] = 1",0,0,0);
	trans[2][28]	= settr(0,0,0,0,0,"light_enabled[((6*4)+0)] = 1",0,0,0);
	trans[2][29]	= settr(0,0,0,0,0,"light_enabled[((6*4)+1)] = 1",0,0,0);
	trans[2][30]	= settr(0,0,0,0,0,"light_enabled[((7*4)+0)] = 1",0,0,0);
	trans[2][31]	= settr(0,0,0,0,0,"light_enabled[((7*4)+1)] = 1",0,0,0);
	trans[2][32]	= settr(0,0,0,0,0,"light_enabled[((7*4)+3)] = 1",0,0,0);
	trans[2][33]	= settr(0,0,0,0,0,"light_enabled[((8*4)+0)] = 1",0,0,0);
	trans[2][34]	= settr(0,0,0,0,0,"light_enabled[((8*4)+3)] = 1",0,0,0);
	trans[2][35]	= settr(0,0,0,0,0,"light_enabled[((9*4)+1)] = 1",0,0,0);
	trans[2][36]	= settr(0,0,0,0,0,"light_green[0] = 1",0,0,0);
	trans[2][37]	= settr(0,0,0,0,0,"light_green[1] = 1",0,0,0);
	trans[2][38]	= settr(0,0,0,0,0,"light_green[2] = 2",0,0,0);
	trans[2][39]	= settr(0,0,0,0,0,"light_green[3] = 0",0,0,0);
	trans[2][40]	= settr(0,0,0,0,0,"light_green[4] = 0",0,0,0);
	trans[2][41]	= settr(0,0,0,0,0,"light_green[5] = 0",0,0,0);
	trans[2][42]	= settr(0,0,0,0,0,"light_green[6] = 0",0,0,0);
	trans[2][43]	= settr(0,0,0,0,0,"light_green[7] = 0",0,0,0);
	trans[2][44]	= settr(0,0,0,0,0,"light_green[8] = 0",0,0,0);
	trans[2][45]	= settr(0,0,0,0,0,"light_green[9] = 1",0,0,0);
	trans[2][46]	= settr(0,0,0,0,0,"i = 0",0,0,0);
	trans[2][53]	= settr(651,2,52,1,0,".(goto)", 1, 2, 0);
	T = trans[2][52] = settr(650,2,0,0,0,"DO", 1, 2, 0);
	T = T->nxt	= settr(650,2,47,0,0,"DO", 1, 2, 0);
	    T->nxt	= settr(650,2,50,0,0,"DO", 1, 2, 0);
	trans[2][47]	= settr(645,2,52,27,27,"((i<(10*4)))", 1, 2, 0); /* m: 48 -> 52,0 */
	reached2[48] = 1;
	trans[2][48]	= settr(0,0,0,0,0,"red_streak[i] = 0",0,0,0);
	trans[2][49]	= settr(0,0,0,0,0,"i = (i+1)",0,0,0);
	trans[2][50]	= settr(648,4,85,28,28,"((i>=(10*4)))", 1, 2, 0); /* m: 55 -> 85,0 */
	reached2[55] = 1;
	trans[2][51]	= settr(649,2,55,1,0,"goto :b12", 1, 2, 0); /* m: 55 -> 0,85 */
	reached2[55] = 1;
	trans[2][54]	= settr(652,2,55,1,0,"break", 1, 2, 0);
	trans[2][55]	= settr(653,4,85,29,29,"tour_stops[((0*4)+0)] = 6", 1, 2, 0); /* m: 56 -> 0,85 */
	reached2[56] = 1;
	trans[2][56]	= settr(0,0,0,0,0,"tour_stops[((0*4)+1)] = 8",0,0,0);
	trans[2][57]	= settr(0,0,0,0,0,"tour_stops[((0*4)+2)] = 2",0,0,0);
	trans[2][58]	= settr(0,0,0,0,0,"tour_stops[((0*4)+3)] = 9",0,0,0);
	trans[2][59]	= settr(0,0,0,0,0,"tour_stops[((1*4)+0)] = 2",0,0,0);
	trans[2][60]	= settr(0,0,0,0,0,"tour_stops[((1*4)+1)] = 8",0,0,0);
	trans[2][61]	= settr(0,0,0,0,0,"tour_stops[((1*4)+2)] = 6",0,0,0);
	trans[2][62]	= settr(0,0,0,0,0,"tour_stops[((1*4)+3)] = 9",0,0,0);
	trans[2][63]	= settr(0,0,0,0,0,"veh_mode[0] = 0",0,0,0);
	trans[2][64]	= settr(0,0,0,0,0,"veh_node[0] = 9",0,0,0);
	trans[2][65]	= settr(0,0,0,0,0,"veh_heading[0] = 255",0,0,0);
	trans[2][66]	= settr(0,0,0,0,0,"veh_dest[0] = 6",0,0,0);
	trans[2][67]	= settr(0,0,0,0,0,"veh_dest_idx[0] = 0",0,0,0);
	trans[2][68]	= settr(0,0,0,0,0,"visited_B[0] = 0",0,0,0);
	trans[2][69]	= settr(0,0,0,0,0,"visited_C[0] = 0",0,0,0);
	trans[2][70]	= settr(0,0,0,0,0,"visited_D[0] = 0",0,0,0);
	trans[2][71]	= settr(0,0,0,0,0,"returned_A[0] = 0",0,0,0);
	trans[2][72]	= settr(0,0,0,0,0,"sq_a_forbidden[0] = 255",0,0,0);
	trans[2][73]	= settr(0,0,0,0,0,"veh_mode[1] = 0",0,0,0);
	trans[2][74]	= settr(0,0,0,0,0,"veh_node[1] = 9",0,0,0);
	trans[2][75]	= settr(0,0,0,0,0,"veh_heading[1] = 255",0,0,0);
	trans[2][76]	= settr(0,0,0,0,0,"veh_dest[1] = 2",0,0,0);
	trans[2][77]	= settr(0,0,0,0,0,"veh_dest_idx[1] = 0",0,0,0);
	trans[2][78]	= settr(0,0,0,0,0,"visited_B[1] = 0",0,0,0);
	trans[2][79]	= settr(0,0,0,0,0,"visited_C[1] = 0",0,0,0);
	trans[2][80]	= settr(0,0,0,0,0,"visited_D[1] = 0",0,0,0);
	trans[2][81]	= settr(0,0,0,0,0,"returned_A[1] = 0",0,0,0);
	trans[2][82]	= settr(0,0,0,0,0,"sq_a_forbidden[1] = 255",0,0,0);
	trans[2][83]	= settr(0,0,0,0,0,"model_initialized = 1",0,0,0);
	trans[2][85]	= settr(683,0,86,30,30,"(run InfraFSM())", 0, 2, 0);
	trans[2][86]	= settr(684,0,87,31,31,"(run VehicleFSM(0))", 0, 2, 0);
	trans[2][87]	= settr(685,0,368,32,32,"(run VehicleFSM(1))", 0, 2, 0);
	trans[2][369]	= settr(967,0,368,1,0,".(goto)", 0, 2, 0);
	T = trans[2][368] = settr(966,0,0,0,0,"DO", 0, 2, 0);
	T = T->nxt	= settr(966,0,88,0,0,"DO", 0, 2, 0);
	T = T->nxt	= settr(966,0,91,0,0,"DO", 0, 2, 0);
	    T->nxt	= settr(966,0,93,0,0,"DO", 0, 2, 0);
	trans[2][88]	= settr(686,0,89,33,0,"((returned_A[0]&&returned_A[1]))", 1, 2, 0);
	trans[2][89]	= settr(687,0,371,34,34,"all_tours_done = 1", 1, 2, 0);
	trans[2][90]	= settr(688,0,371,1,0,"goto :b13", 0, 2, 0);
	trans[2][91]	= settr(689,0,371,35,35,"((tick_count>=120))", 0, 2, 0);
	trans[2][92]	= settr(690,0,371,1,0,"goto :b13", 0, 2, 0);
	trans[2][93]	= settr(691,0,106,2,0,"else", 0, 2, 0);
/*->*/	trans[2][106]	= settr(704,32,107,36,36,"D_STEP949", 1, 2, 0);
	trans[2][107]	= settr(705,0,108,37,37,"tick_infra!0", 1, 3, 0);
	trans[2][108]	= settr(706,0,109,38,38,"done_infra?dummy", 1, 504, 0);
	trans[2][109]	= settr(707,0,110,39,39,"tick_vehicle[0]!0", 1, 5, 0);
	trans[2][110]	= settr(708,0,111,40,40,"tick_vehicle[1]!0", 1, 5, 0);
	trans[2][111]	= settr(709,0,112,41,41,"done_vehicle[0]?dummy", 1, 506, 0);
	trans[2][112]	= settr(710,0,338,42,42,"done_vehicle[1]?dummy", 1, 506, 0);
/*->*/	trans[2][338]	= settr(936,32,339,43,43,"D_STEP973", 1, 2, 0);
	trans[2][339]	= settr(937,0,340,44,0,"assert(!(collision))", 1, 2, 0);
	trans[2][340]	= settr(938,0,341,45,0,"assert(!(red_violation))", 1, 2, 0);
	trans[2][341]	= settr(939,0,342,46,0,"assert(!(uturn_violation))", 1, 2, 0);
	trans[2][342]	= settr(940,0,343,47,0,"assert(!(opposite_direction_violation))", 1, 2, 0);
	trans[2][343]	= settr(941,0,344,48,0,"assert((crossing_count[0]<=1))", 1, 2, 0);
	trans[2][344]	= settr(942,0,345,49,0,"assert((crossing_count[1]<=1))", 1, 2, 0);
	trans[2][345]	= settr(943,0,346,50,0,"assert((crossing_count[2]<=1))", 1, 2, 0);
	trans[2][346]	= settr(944,0,347,51,0,"assert((crossing_count[3]<=1))", 1, 2, 0);
	trans[2][347]	= settr(945,0,348,52,0,"assert((crossing_count[4]<=1))", 1, 2, 0);
	trans[2][348]	= settr(946,0,349,53,0,"assert((crossing_count[5]<=1))", 1, 2, 0);
	trans[2][349]	= settr(947,0,350,54,0,"assert((crossing_count[6]<=1))", 1, 2, 0);
	trans[2][350]	= settr(948,0,351,55,0,"assert((crossing_count[7]<=1))", 1, 2, 0);
	trans[2][351]	= settr(949,0,352,56,0,"assert((crossing_count[8]<=1))", 1, 2, 0);
	trans[2][352]	= settr(950,0,353,57,0,"assert(((light_green[0]<=3)&&light_enabled[((0*4)+light_green[0])]))", 1, 2, 0);
	trans[2][353]	= settr(951,0,354,58,0,"assert(((light_green[1]<=3)&&light_enabled[((1*4)+light_green[1])]))", 1, 2, 0);
	trans[2][354]	= settr(952,0,355,59,0,"assert(((light_green[2]<=3)&&light_enabled[((2*4)+light_green[2])]))", 1, 2, 0);
	trans[2][355]	= settr(953,0,356,60,0,"assert(((light_green[3]<=3)&&light_enabled[((3*4)+light_green[3])]))", 1, 2, 0);
	trans[2][356]	= settr(954,0,357,61,0,"assert(((light_green[4]<=3)&&light_enabled[((4*4)+light_green[4])]))", 1, 2, 0);
	trans[2][357]	= settr(955,0,358,62,0,"assert(((light_green[5]<=3)&&light_enabled[((5*4)+light_green[5])]))", 1, 2, 0);
	trans[2][358]	= settr(956,0,359,63,0,"assert(((light_green[6]<=3)&&light_enabled[((6*4)+light_green[6])]))", 1, 2, 0);
	trans[2][359]	= settr(957,0,360,64,0,"assert(((light_green[7]<=3)&&light_enabled[((7*4)+light_green[7])]))", 1, 2, 0);
	trans[2][360]	= settr(958,0,365,65,0,"assert(((light_green[8]<=3)&&light_enabled[((8*4)+light_green[8])]))", 1, 2, 0);
	T = trans[2][365] = settr(963,0,0,0,0,"IF", 0, 2, 0);
	T = T->nxt	= settr(963,0,361,0,0,"IF", 0, 2, 0);
	    T->nxt	= settr(963,0,363,0,0,"IF", 0, 2, 0);
	trans[2][361]	= settr(959,0,362,66,0,"((returned_A[0]&&returned_A[1]))", 1, 2, 0);
	trans[2][362]	= settr(960,0,367,67,67,"all_tours_done = 1", 1, 2, 0);
	trans[2][366]	= settr(964,0,367,1,0,".(goto)", 0, 2, 0); /* m: 367 -> 0,368 */
	reached2[367] = 1;
	trans[2][363]	= settr(961,0,364,2,0,"else", 0, 2, 0);
	trans[2][364]	= settr(962,0,368,68,68,"(1)", 0, 2, 0); /* m: 367 -> 368,0 */
	reached2[367] = 1;
	trans[2][367]	= settr(965,0,368,69,69,"tick_count = (tick_count+1)", 0, 2, 0);
	trans[2][370]	= settr(968,0,371,1,0,"break", 0, 2, 0);
	trans[2][371]	= settr(969,0,0,70,70,"-end-", 0, 3500, 0);

	/* proctype 1: VehicleFSM */

	trans[1] = (Trans **) emalloc(358*sizeof(Trans *));

	trans[1][355]	= settr(596,0,354,1,0,".(goto)", 0, 2, 0);
	T = trans[1][354] = settr(595,0,0,0,0,"DO", 0, 2, 0);
	    T->nxt	= settr(595,0,1,0,0,"DO", 0, 2, 0);
	trans[1][1]	= settr(242,0,352,71,71,"tick_vehicle[vid]?dummy", 1, 505, 0);
/*->*/	trans[1][352]	= settr(593,32,353,72,72,"D_STEP563", 1, 2, 0);
	trans[1][353]	= settr(594,0,354,73,73,"done_vehicle[vid]!0", 1, 6, 0);
	trans[1][356]	= settr(597,0,357,1,0,"break", 0, 2, 0);
	trans[1][357]	= settr(598,0,0,74,74,"-end-", 0, 3500, 0);

	/* proctype 0: InfraFSM */

	trans[0] = (Trans **) emalloc(243*sizeof(Trans *));

	trans[0][240]	= settr(239,0,239,1,0,".(goto)", 0, 2, 0);
	T = trans[0][239] = settr(238,0,0,0,0,"DO", 0, 2, 0);
	    T->nxt	= settr(238,0,1,0,0,"DO", 0, 2, 0);
	trans[0][1]	= settr(0,0,213,75,75,"tick_infra?dummy", 1, 503, 0);
/*->*/	trans[0][213]	= settr(212,32,214,76,76,"D_STEP234", 1, 2, 0);
	trans[0][214]	= settr(213,0,235,77,77,"nid2 = 0", 0, 2, 0);
	trans[0][236]	= settr(235,0,235,1,0,".(goto)", 0, 2, 0);
	T = trans[0][235] = settr(234,0,0,0,0,"DO", 0, 2, 0);
	T = T->nxt	= settr(234,0,215,0,0,"DO", 0, 2, 0);
	    T->nxt	= settr(234,0,233,0,0,"DO", 0, 2, 0);
	trans[0][215]	= settr(214,0,228,78,78,"((nid2<9))", 0, 2, 0); /* m: 216 -> 228,0 */
	reached0[216] = 1;
	trans[0][216]	= settr(0,0,0,0,0,"gc = 0",0,0,0);
	trans[0][217]	= settr(0,0,0,0,0,"d2 = 0",0,0,0);
	trans[0][229]	= settr(228,0,228,1,0,".(goto)", 0, 2, 0);
	T = trans[0][228] = settr(227,0,0,0,0,"DO", 0, 2, 0);
	T = T->nxt	= settr(227,0,218,0,0,"DO", 0, 2, 0);
	    T->nxt	= settr(227,0,226,0,0,"DO", 0, 2, 0);
	trans[0][218]	= settr(217,0,223,79,0,"((d2<4))", 0, 2, 0);
	T = trans[0][223] = settr(222,0,0,0,0,"IF", 0, 2, 0);
	T = T->nxt	= settr(222,0,219,0,0,"IF", 0, 2, 0);
	    T->nxt	= settr(222,0,221,0,0,"IF", 0, 2, 0);
	trans[0][219]	= settr(218,0,220,80,0,"((light_enabled[((nid2*4)+d2)]&&(d2==light_green[nid2])))", 1, 2, 0);
	trans[0][220]	= settr(219,0,228,81,81,"gc = (gc+1)", 0, 2, 0); /* m: 225 -> 0,228 */
	reached0[225] = 1;
	trans[0][224]	= settr(223,0,225,1,0,".(goto)", 0, 2, 0); /* m: 225 -> 0,228 */
	reached0[225] = 1;
	trans[0][221]	= settr(220,0,222,2,0,"else", 0, 2, 0);
	trans[0][222]	= settr(221,0,228,82,82,"(1)", 0, 2, 0); /* m: 225 -> 228,0 */
	reached0[225] = 1;
	trans[0][225]	= settr(224,0,228,83,83,"d2 = (d2+1)", 0, 2, 0);
	trans[0][226]	= settr(225,0,235,84,84,"((d2>=4))", 0, 2, 0); /* m: 231 -> 235,0 */
	reached0[231] = 1;
	trans[0][227]	= settr(226,0,231,1,0,"goto :b9", 0, 2, 0); /* m: 231 -> 0,235 */
	reached0[231] = 1;
	trans[0][230]	= settr(229,0,231,1,0,"break", 0, 2, 0);
	trans[0][231]	= settr(230,0,235,85,85,"assert((gc==1))", 0, 2, 0); /* m: 232 -> 0,235 */
	reached0[232] = 1;
	trans[0][232]	= settr(0,0,0,0,0,"nid2 = (nid2+1)",0,0,0);
	trans[0][233]	= settr(232,0,238,86,86,"((nid2>=9))", 0, 2, 0);
	trans[0][234]	= settr(233,0,238,1,0,"goto :b8", 0, 2, 0);
	trans[0][237]	= settr(236,0,238,1,0,"break", 0, 2, 0);
	trans[0][238]	= settr(237,0,239,87,87,"done_infra!0", 1, 4, 0);
	trans[0][241]	= settr(240,0,242,1,0,"break", 0, 2, 0);
	trans[0][242]	= settr(241,0,0,88,88,"-end-", 0, 3500, 0);
	/* np_ demon: */
	trans[_NP_] = (Trans **) emalloc(3*sizeof(Trans *));
	T = trans[_NP_][0] = settr(9997,0,1,_T5,0,"(np_)", 1,2,0);
	    T->nxt	  = settr(9998,0,0,_T2,0,"(1)",   0,2,0);
	T = trans[_NP_][1] = settr(9999,0,1,_T5,0,"(np_)", 1,2,0);
}

Trans *
settr(	int t_id, int a, int b, int c, int d,
	char *t, int g, int tpe0, int tpe1)
{	Trans *tmp = (Trans *) emalloc(sizeof(Trans));

	tmp->atom  = a&(6|32);	/* only (2|8|32) have meaning */
	if (!g) tmp->atom |= 8;	/* no global references */
	tmp->st    = b;
	tmp->tpe[0] = tpe0;
	tmp->tpe[1] = tpe1;
	tmp->tp    = t;
	tmp->t_id  = t_id;
	tmp->forw  = c;
	tmp->back  = d;
	return tmp;
}

Trans *
cpytr(Trans *a)
{	Trans *tmp = (Trans *) emalloc(sizeof(Trans));

	int i;
	tmp->atom  = a->atom;
	tmp->st    = a->st;
#ifdef HAS_UNLESS
	tmp->e_trans = a->e_trans;
	for (i = 0; i < HAS_UNLESS; i++)
		tmp->escp[i] = a->escp[i];
#endif
	tmp->tpe[0] = a->tpe[0];
	tmp->tpe[1] = a->tpe[1];
	for (i = 0; i < 6; i++)
	{	tmp->qu[i] = a->qu[i];
		tmp->ty[i] = a->ty[i];
	}
	tmp->tp    = (char *) emalloc(strlen(a->tp)+1);
	strcpy(tmp->tp, a->tp);
	tmp->t_id  = a->t_id;
	tmp->forw  = a->forw;
	tmp->back  = a->back;
	return tmp;
}

#ifndef NOREDUCE
int
srinc_set(int n)
{	if (n <= 2) return LOCAL;
	if (n <= 2+  DELTA) return Q_FULL_F; /* 's' or nfull  */
	if (n <= 2+2*DELTA) return Q_EMPT_F; /* 'r' or nempty */
	if (n <= 2+3*DELTA) return Q_EMPT_T; /* empty */
	if (n <= 2+4*DELTA) return Q_FULL_T; /* full  */
	if (n ==   5*DELTA) return GLOBAL;
	if (n ==   6*DELTA) return TIMEOUT_F;
	if (n ==   7*DELTA) return ALPHA_F;
	Uerror("cannot happen srinc_class");
	return BAD;
}
int
srunc(int n, int m)
{	switch(m) {
	case Q_FULL_F: return n-2;
	case Q_EMPT_F: return n-2-DELTA;
	case Q_EMPT_T: return n-2-2*DELTA;
	case Q_FULL_T: return n-2-3*DELTA;
	case ALPHA_F:
	case TIMEOUT_F: return 257; /* non-zero, and > MAXQ */
	}
	Uerror("cannot happen srunc");
	return 0;
}
#endif
int cnt;
#ifdef HAS_UNLESS
int
isthere(Trans *a, int b)
{	Trans *t;
	for (t = a; t; t = t->nxt)
		if (t->t_id == b)
			return 1;
	return 0;
}
#endif
#ifndef NOREDUCE
int
mark_safety(Trans *t) /* for conditional safety */
{	int g = 0, i, j, k;

	if (!t) return 0;
	if (t->qu[0])
		return (t->qu[1])?2:1;	/* marked */

	for (i = 0; i < 2; i++)
	{	j = srinc_set(t->tpe[i]);
		if (j >= GLOBAL && j != ALPHA_F)
			return -1;
		if (j != LOCAL)
		{	k = srunc(t->tpe[i], j);
			if (g == 0
			||  t->qu[0] != k
			||  t->ty[0] != j)
			{	t->qu[g] = k;
				t->ty[g] = j;
				g++;
	}	}	}
	return g;
}
#endif
void
retrans(int n, int m, int is, short srcln[], uchar reach[], uchar lpstate[])
	/* process n, with m states, is=initial state */
{	Trans *T0, *T1, *T2, *T3;
	Trans *T4, *T5; /* t_reverse or has_unless */
	int i;
#if defined(HAS_UNLESS) || !defined(NOREDUCE)
	int k;
#endif
#ifndef NOREDUCE
	int g, h, j, aa;
#endif
#ifdef HAS_UNLESS
	int p;
#endif
	if (state_tables >= 4)
	{	printf("STEP 1 %s\n", 
			procname[n]);
		for (i = 1; i < m; i++)
		for (T0 = trans[n][i]; T0; T0 = T0->nxt)
			crack(n, i, T0, srcln);
		return;
	}
	do {
		for (i = 1, cnt = 0; i < m; i++)
		{	T2 = trans[n][i];
			T1 = T2?T2->nxt:(Trans *)0;
/* prescan: */		for (T0 = T1; T0; T0 = T0->nxt)
/* choice in choice */	{	if (T0->st && trans[n][T0->st]
				&&  trans[n][T0->st]->nxt)
					break;
			}
#if 0
		if (T0)
		printf("\tstate %d / %d: choice in choice\n",
		i, T0->st);
#endif
			if (T0)
			for (T0 = T1; T0; T0 = T0->nxt)
			{	T3 = trans[n][T0->st];
				if (!T3->nxt)
				{	T2->nxt = cpytr(T0);
					T2 = T2->nxt;
					imed(T2, T0->st, n, i);
					continue;
				}
				do {	T3 = T3->nxt;
					T2->nxt = cpytr(T3);
					T2 = T2->nxt;
					imed(T2, T0->st, n, i);
				} while (T3->nxt);
				cnt++;
			}
		}
	} while (cnt);
	if (state_tables >= 3)
	{	printf("STEP 2 %s\n", 
			procname[n]);
		for (i = 1; i < m; i++)
		for (T0 = trans[n][i]; T0; T0 = T0->nxt)
			crack(n, i, T0, srcln);
		return;
	}
	for (i = 1; i < m; i++)
	{	if (trans[n][i] && trans[n][i]->nxt) /* optimize */
		{	T1 = trans[n][i]->nxt;
#if 0
			printf("\t\tpull %d (%d) to %d\n",
			T1->st, T1->forw, i);
#endif
			srcln[i] = srcln[T1->st];	/* Oyvind Teig, 5.2.0 */

			if (!trans[n][T1->st]) continue;
			T0 = cpytr(trans[n][T1->st]);
			trans[n][i] = T0;
			reach[T1->st] = 1;
			imed(T0, T1->st, n, i);
			for (T1 = T1->nxt; T1; T1 = T1->nxt)
			{
#if 0
			printf("\t\tpull %d (%d) to %d\n",
				T1->st, T1->forw, i);
#endif
		/*		srcln[i] = srcln[T1->st];  gh: not useful */
				if (!trans[n][T1->st]) continue;
				T0->nxt = cpytr(trans[n][T1->st]);
				T0 = T0->nxt;
				reach[T1->st] = 1;
				imed(T0, T1->st, n, i);
	}	}	}
	if (state_tables >= 2)
	{	printf("STEP 3 %s\n", 
			procname[n]);
		for (i = 1; i < m; i++)
		for (T0 = trans[n][i]; T0; T0 = T0->nxt)
			crack(n, i, T0, srcln);
		return;
	}
#ifdef HAS_UNLESS
	for (i = 1; i < m; i++)
	{	if (!trans[n][i]) continue;
		/* check for each state i if an
		 * escape to some state p is defined
		 * if so, copy and mark p's transitions
		 * and prepend them to the transition-
		 * list of state i
		 */
	 if (!like_java) /* the default */
	 {	for (T0 = trans[n][i]; T0; T0 = T0->nxt)
		for (k = HAS_UNLESS-1; k >= 0; k--)
		{	if (p = T0->escp[k])
			for (T1 = trans[n][p]; T1; T1 = T1->nxt)
			{	if (isthere(trans[n][i], T1->t_id))
					continue;
				T2 = cpytr(T1);
				T2->e_trans = p;
				T2->nxt = trans[n][i];
				trans[n][i] = T2;
		}	}
	 } else /* outermost unless checked first */
	 {	T4 = T3 = (Trans *) 0;
		for (T0 = trans[n][i]; T0; T0 = T0->nxt)
		for (k = HAS_UNLESS-1; k >= 0; k--)
		{	if (p = T0->escp[k])
			for (T1 = trans[n][p]; T1; T1 = T1->nxt)
			{	if (isthere(trans[n][i], T1->t_id))
					continue;
				T2 = cpytr(T1);
				T2->nxt = (Trans *) 0;
				T2->e_trans = p;
				if (T3)	T3->nxt = T2;
				else	T4 = T2;
				T3 = T2;
		}	}
		if (T4)
		{	T3->nxt = trans[n][i];
			trans[n][i] = T4;
		}
	 }
	}
#endif
#ifndef NOREDUCE
	for (i = 1; i < m; i++)
	{	if (a_cycles)
		{ /* moves through these states are visible */
	#if PROG_LAB>0 && defined(HAS_NP)
			if (progstate[n][i])
				goto degrade;
			for (T1 = trans[n][i]; T1; T1 = T1->nxt)
				if (progstate[n][T1->st])
					goto degrade;
	#endif
			if (accpstate[n][i] || visstate[n][i])
				goto degrade;
			for (T1 = trans[n][i]; T1; T1 = T1->nxt)
				if (accpstate[n][T1->st])
					goto degrade;
		}
		T1 = trans[n][i];
		if (!T1) continue;
		g = mark_safety(T1);	/* V3.3.1 */
		if (g < 0) goto degrade; /* global */
		/* check if mixing of guards preserves reduction */
		if (T1->nxt)
		{	k = 0;
			for (T0 = T1; T0; T0 = T0->nxt)
			{	if (!(T0->atom&8))
					goto degrade;
				for (aa = 0; aa < 2; aa++)
				{	j = srinc_set(T0->tpe[aa]);
					if (j >= GLOBAL && j != ALPHA_F)
						goto degrade;
					if (T0->tpe[aa]
					&&  T0->tpe[aa]
					!=  T1->tpe[0])
						k = 1;
			}	}
			/* g = 0;	V3.3.1 */
			if (k)	/* non-uniform selection */
			for (T0 = T1; T0; T0 = T0->nxt)
			for (aa = 0; aa < 2; aa++)
			{	j = srinc_set(T0->tpe[aa]);
				if (j != LOCAL)
				{	k = srunc(T0->tpe[aa], j);
					for (h = 0; h < 6; h++)
						if (T1->qu[h] == k
						&&  T1->ty[h] == j)
							break;
					if (h >= 6)
					{	T1->qu[g%6] = k;
						T1->ty[g%6] = j;
						g++;
			}	}	}
			if (g > 6)
			{	T1->qu[0] = 0;	/* turn it off */
				printf("pan: warning, line %d, ",
					srcln[i]);
			 	printf("too many stmnt types (%d)",
					g);
			  	printf(" in selection\n");
			  goto degrade;
			}
		}
		/* mark all options global if >=1 is global */
		for (T1 = trans[n][i]; T1; T1 = T1->nxt)
			if (!(T1->atom&8)) break;
		if (T1)
degrade:	for (T1 = trans[n][i]; T1; T1 = T1->nxt)
			T1->atom &= ~8;	/* mark as unsafe */
		/* can only mix 'r's or 's's if on same chan */
		/* and not mixed with other local operations */
		T1 = trans[n][i];
		if (!T1 || T1->qu[0]) continue;
		j = T1->tpe[0];
		if (T1->nxt && T1->atom&8)
		{ if (j == 5*DELTA)
		  {	printf("warning: line %d ", srcln[i]);
			printf("mixed condition ");
			printf("(defeats reduction)\n");
			goto degrade;
		  }
		  for (T0 = T1; T0; T0 = T0->nxt)
		  for (aa = 0; aa < 2; aa++)
		  if  (T0->tpe[aa] && T0->tpe[aa] != j)
		  {	printf("warning: line %d ", srcln[i]);
			printf("[%d-%d] mixed %stion ",
				T0->tpe[aa], j, 
				(j==5*DELTA)?"condi":"selec");
			printf("(defeats reduction)\n");
			printf("	'%s' <-> '%s'\n",
				T1->tp, T0->tp);
			goto degrade;
		} }
	}
#endif
	for (i = 1; i < m; i++)
	{	T2 = trans[n][i];
		if (!T2
		||  T2->nxt
		||  strncmp(T2->tp, ".(goto)", 7)
		||  !stopstate[n][i])
			continue;
		stopstate[n][T2->st] = 1;
	}
	if (state_tables && !verbose)
	{	if (dodot)
		{	char buf[256], *q = buf, *p = procname[n];
			while (*p != '\0')
			{	if (*p != ':')
				{	*q++ = *p;
				}
				p++;
			}
			*q = '\0';
			printf("digraph ");
			switch (Btypes[n]) {
			case I_PROC:  printf("init {\n"); break;
			case N_CLAIM: printf("claim_%s {\n", buf); break;
			case E_TRACE: printf("notrace {\n"); break;
			case N_TRACE: printf("trace {\n"); break;
			default:      printf("p_%s {\n", buf); break;
			}
			printf("size=\"8,10\";\n");
			printf("  GT [shape=box,style=dotted,label=\"%s\"];\n", buf);
			printf("  GT -> S%d;\n", is);
		} else
		{	switch (Btypes[n]) {
			case I_PROC:  printf("init\n"); break;
			case N_CLAIM: printf("claim %s\n", procname[n]); break;
			case E_TRACE: printf("notrace assertion\n"); break;
			case N_TRACE: printf("trace assertion\n"); break;
			default:      printf("proctype %s\n", procname[n]); break;
		}	}
		for (i = 1; i < m; i++)
		{	reach[i] = 1;
		}
		tagtable(n, m, is, srcln, reach);
		if (dodot) printf("}\n");
	} else
	for (i = 1; i < m; i++)
	{	int nrelse;
		if (Btypes[n] != N_CLAIM)
		{	for (T0 = trans[n][i]; T0; T0 = T0->nxt)
			{	if (T0->st == i
				&& strcmp(T0->tp, "(1)") == 0)
				{	printf("error: proctype '%s' ",
						procname[n]);
		  			printf("line %d, state %d: has un",
						srcln[i], i);
					printf("conditional self-loop\n");
					pan_exit(1);
		}	}	}
		nrelse = 0;
		for (T0 = trans[n][i]; T0; T0 = T0->nxt)
		{	if (strcmp(T0->tp, "else") == 0)
				nrelse++;
		}
		if (nrelse > 1)
		{	printf("error: proctype '%s' state",
				procname[n]);
		  	printf(" %d, inherits %d", i, nrelse);
		  	printf(" 'else' stmnts\n");
			pan_exit(1);
	}	}
#if !defined(LOOPSTATE) && !defined(BFS_PAR)
	if (state_tables)
#endif
	do_dfs(n, m, is, srcln, reach, lpstate);

	if (!t_reverse)
	{	return;
	}
	/* process n, with m states, is=initial state -- reverse list */
	if (!state_tables && Btypes[n] != N_CLAIM)
	{	for (i = 1; i < m; i++)
		{	Trans *Tx = (Trans *) 0; /* list of escapes */
			Trans *Ty = (Trans *) 0; /* its tail element */
			T1 = (Trans *) 0; /* reversed list */
			T2 = (Trans *) 0; /* its tail */
			T3 = (Trans *) 0; /* remembers possible 'else' */

			/* find unless-escapes, they should go first */
			T4 = T5 = T0 = trans[n][i];
	#ifdef HAS_UNLESS
			while (T4 && T4->e_trans) /* escapes are first in orig list */
			{	T5 = T4;	  /* remember predecessor */
				T4 = T4->nxt;
			}
	#endif
			/* T4 points to first non-escape, T5 to its parent, T0 to original list */
			if (T4 != T0)		 /* there was at least one escape */
			{	T3 = T5->nxt;		 /* start of non-escapes */
				T5->nxt = (Trans *) 0;	 /* separate */
				Tx = T0;		 /* start of the escapes */
				Ty = T5;		 /* its tail */
				T0 = T3;		 /* the rest, to be reversed */
			}
			/* T0 points to first non-escape, Tx to the list of escapes, Ty to its tail */

			/* first tail-add non-escape transitions, reversed */
			T3 = (Trans *) 0;
			for (T5 = T0; T5; T5 = T4)
			{	T4 = T5->nxt;
	#ifdef HAS_UNLESS
				if (T5->e_trans)
				{	printf("error: cannot happen!\n");
					continue;
				}
	#endif
				if (strcmp(T5->tp, "else") == 0)
				{	T3 = T5;
					T5->nxt = (Trans *) 0;
				} else
				{	T5->nxt = T1;
					if (!T1) { T2 = T5; }
					T1 = T5;
			}	}
			/* T3 points to a possible else, which is removed from the list */
			/* T1 points to the reversed list so far (without escapes) */
			/* T2 points to the tail element -- where the else should go */
			if (T2 && T3)
			{	T2->nxt = T3;	/* add else */
			} else
			{	if (T3) /* there was an else, but there's no tail */
				{	if (!T1)	/* and no reversed list */
					{	T1 = T3; /* odd, but possible */
					} else		/* even stranger */
					{	T1->nxt = T3;
			}	}	}

			/* add in the escapes, to that they appear at the front */
			if (Tx && Ty) { Ty->nxt = T1; T1 = Tx; }

			trans[n][i] = T1;
			/* reversed, with escapes first and else last */
	}	}
	if (state_tables && verbose)
	{	printf("FINAL proctype %s\n", 
			procname[n]);
		for (i = 1; i < m; i++)
		for (T0 = trans[n][i]; T0; T0 = T0->nxt)
			crack(n, i, T0, srcln);
	}
}
void
imed(Trans *T, int v, int n, int j)	/* set intermediate state */
{	progstate[n][T->st] |= progstate[n][v];
	accpstate[n][T->st] |= accpstate[n][v];
	stopstate[n][T->st] |= stopstate[n][v];
	mapstate[n][j] = T->st;
}
void
tagtable(int n, int m, int is, short srcln[], uchar reach[])
{	Trans *z;

	if (is >= m || !trans[n][is]
	||  is <= 0 || reach[is] == 0)
		return;
	reach[is] = 0;
	if (state_tables)
	for (z = trans[n][is]; z; z = z->nxt)
	{	if (dodot)
			dot_crack(n, is, z);
		else
			crack(n, is, z, srcln);
	}

	for (z = trans[n][is]; z; z = z->nxt)
	{
#ifdef HAS_UNLESS
		int i, j;
#endif
		tagtable(n, m, z->st, srcln, reach);
#ifdef HAS_UNLESS
		for (i = 0; i < HAS_UNLESS; i++)
		{	j = trans[n][is]->escp[i];
			if (!j) break;
			tagtable(n, m, j, srcln, reach);
		}
#endif
	}
}

extern Trans *t_id_lkup[];

void
dfs_table(int n, int m, int is, short srcln[], uchar reach[], uchar lpstate[])
{	Trans *z;

	if (is >= m || is <= 0 || !trans[n][is])
		return;
	if ((reach[is] & (4|8|16)) != 0)
	{	if ((reach[is] & (8|16)) == 16)	/* on stack, not yet recorded */
		{	lpstate[is] = 1;
			reach[is] |= 8; /* recorded */
			if (state_tables && verbose)
			{	printf("state %d line %d is a loopstate\n", is, srcln[is]);
		}	}
		return;
	}
	reach[is] |= (4|16);	/* visited | onstack */
	for (z = trans[n][is]; z; z = z->nxt)
	{	t_id_lkup[z->t_id] = z;
#ifdef HAS_UNLESS
		int i, j;
#endif
		dfs_table(n, m, z->st, srcln, reach, lpstate);
#ifdef HAS_UNLESS
		for (i = 0; i < HAS_UNLESS; i++)
		{	j = trans[n][is]->escp[i];
			if (!j) break;
			dfs_table(n, m, j, srcln, reach, lpstate);
		}
#endif
	}
	reach[is] &= ~16; /* no longer on stack */
}
void
do_dfs(int n, int m, int is, short srcln[], uchar reach[], uchar lpstate[])
{	int i;
	dfs_table(n, m, is, srcln, reach, lpstate);
	for (i = 0; i < m; i++)
		reach[i] &= ~(4|8|16);
}
void
crack(int n, int j, Trans *z, short srcln[])
{	int i;

	if (!z) return;
	printf("	state %3d -(tr %3d)-> state %3d  ",
		j, z->forw, z->st);
	printf("[id %3d tp %3d", z->t_id, z->tpe[0]);
	if (z->tpe[1]) printf(",%d", z->tpe[1]);
#ifdef HAS_UNLESS
	if (z->e_trans)
		printf(" org %3d", z->e_trans);
	else if (state_tables >= 2)
	for (i = 0; i < HAS_UNLESS; i++)
	{	if (!z->escp[i]) break;
		printf(" esc %d", z->escp[i]);
	}
#endif
	printf("]");
	printf(" [%s%s%s%s%s] %s:%d => ",
		z->atom&6?"A":z->atom&32?"D":"-",
		accpstate[n][j]?"a" :"-",
		stopstate[n][j]?"e" : "-",
		progstate[n][j]?"p" : "-",
		z->atom & 8 ?"L":"G",
		PanSource, srcln[j]);
	for (i = 0; z->tp[i]; i++)
		if (z->tp[i] == '\n')
			printf("\\n");
		else
			putchar(z->tp[i]);
	if (verbose && z->qu[0])
	{	printf("\t[");
		for (i = 0; i < 6; i++)
			if (z->qu[i])
				printf("(%d,%d)",
				z->qu[i], z->ty[i]);
		printf("]");
	}
	printf("\n");
	fflush(stdout);
}
/* spin -a m.pml; cc -o pan pan.c; ./pan -D | dot -Tps > foo.ps; ps2pdf foo.ps */
void
dot_crack(int n, int j, Trans *z)
{	int i;

	if (!z) return;
	printf("	S%d -> S%d  [color=black", j, z->st);

	if (z->atom&6) printf(",style=dashed");
	else if (z->atom&32) printf(",style=dotted");
	else if (z->atom&8) printf(",style=solid");
	else printf(",style=bold");

	printf(",label=\"");
	for (i = 0; z->tp[i]; i++)
	{	if (z->tp[i] == '\\'
		&&  z->tp[i+1] == 'n')
		{	i++; printf(" ");
		} else
		{	putchar(z->tp[i]);
	}	}
	printf("\"];\n");
	if (accpstate[n][j]) printf("  S%d [color=red,style=bold];\n", j);
	else if (progstate[n][j]) printf("  S%d [color=green,style=bold];\n", j);
	if (stopstate[n][j]) printf("  S%d [color=blue,style=bold,shape=box];\n", j);
}

#ifdef VAR_RANGES
#define BYTESIZE	32	/* 2^8 : 2^3 = 256:8 = 32 */

typedef struct Vr_Ptr {
	char	*nm;
	uchar	vals[BYTESIZE];
	struct Vr_Ptr *nxt;
} Vr_Ptr;
Vr_Ptr *ranges = (Vr_Ptr *) 0;

void
logval(char *s, int v)
{	Vr_Ptr *tmp;

	if (v<0 || v > 255) return;
	for (tmp = ranges; tmp; tmp = tmp->nxt)
		if (!strcmp(tmp->nm, s))
			goto found;
	tmp = (Vr_Ptr *) emalloc(sizeof(Vr_Ptr));
	tmp->nxt = ranges;
	ranges = tmp;
	tmp->nm = s;
found:
	tmp->vals[(v)/8] |= 1<<((v)%8);
}

void
dumpval(uchar X[], int range)
{	int w, x, i, j = -1;

	for (w = i = 0; w < range; w++)
	for (x = 0; x < 8; x++, i++)
	{
from:		if ((X[w] & (1<<x)))
		{	printf("%d", i);
			j = i;
			goto upto;
	}	}
	return;
	for (w = 0; w < range; w++)
	for (x = 0; x < 8; x++, i++)
	{
upto:		if (!(X[w] & (1<<x)))
		{	if (i-1 == j)
				printf(", ");
			else
				printf("-%d, ", i-1);
			goto from;
	}	}
	if (j >= 0 && j != 255)
		printf("-255");
}

void
dumpranges(void)
{	Vr_Ptr *tmp;
	printf("\nValues assigned within ");
	printf("interval [0..255]:\n");
	for (tmp = ranges; tmp; tmp = tmp->nxt)
	{	printf("\t%s\t: ", tmp->nm);
		dumpval(tmp->vals, BYTESIZE);
		printf("\n");
	}
}
#endif
