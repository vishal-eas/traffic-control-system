#define rand	pan_rand
#define pthread_equal(a,b)	((a)==(b))
#if defined(HAS_CODE) && defined(VERBOSE)
	#ifdef BFS_PAR
		bfs_printf("Pr: %d Tr: %d\n", II, t->forw);
	#else
		cpu_printf("Pr: %d Tr: %d\n", II, t->forw);
	#endif
#endif
	switch (t->forw) {
	default: Uerror("bad forward move");
	case 0:	/* if without executable clauses */
		continue;
	case 1: /* generic 'goto' or 'skip' */
		IfNotBlocked
		_m = 3; goto P999;
	case 2: /* generic 'else' */
		IfNotBlocked
		if (trpt->o_pm&1) continue;
		_m = 3; goto P999;

		 /* CLAIM valid_light_topology */
	case 3: // STATE 1 - _spin_nvr.tmp:80 - [(!((!(model_initialized)||(((((((((((((((((((((((((((((((((((!(light_enabled[((0*4)+0)])&&light_enabled[((0*4)+1)])&&light_enabled[((0*4)+2)])&&light_enabled[((0*4)+3)])&&!(light_enabled[((1*4)+0)]))&&light_enabled[((1*4)+1)])&&light_enabled[((1*4)+2)])&&light_enabled[((1*4)+3)])&&!(light_enabled[((2*4)+0)]))&&!(light_enabled[((2*4)+1)]))&&light_enabled[((2*4)+2)])&&light_enabled[((2*4)+3)])&&light_enabled[((3*4)+0)])&&light_enabled[((3*4)+1)])&&light_enabled[((3*4)+2)])&&!(light_enabled[((3*4)+3)]))&&light_enabled[((4*4)+0)])&&light_enabled[((4*4)+1)])&&light_enabled[((4*4)+2)])&&light_enabled[((4*4)+3)])&&light_enabled[((5*4)+0)])&&!(light_enabled[((5*4)+1)]))&&light_enabled[((5*4)+2)])&&light_enabled[((5*4)+3)])&&light_enabled[((6*4)+0)])&&light_enabled[((6*4)+1)])&&!(light_enabled[((6*4)+2)]))&&!(light_enabled[((6*4)+3)]))&&light_enabled[((7*4)+0)])&&light_enabled[((7*4)+1)])&&!(light_enabled[((7*4)+2)]))&&light_enabled[((7*4)+3)])&&light_enabled[((8*4)+0)])&&!(light_enabled[((8*4)+1)]))&&!(light_enabled[((8*4)+2)]))&&light_enabled[((8*4)+3)]))))] (6:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[12][1] = 1;
		if (!( !(( !(((int)now.model_initialized))||((((((((((((((((((((((((((((((((((( !(((int)now.light_enabled[ Index(((0*4)+0), 40) ]))&&((int)now.light_enabled[ Index(((0*4)+1), 40) ]))&&((int)now.light_enabled[ Index(((0*4)+2), 40) ]))&&((int)now.light_enabled[ Index(((0*4)+3), 40) ]))&& !(((int)now.light_enabled[ Index(((1*4)+0), 40) ])))&&((int)now.light_enabled[ Index(((1*4)+1), 40) ]))&&((int)now.light_enabled[ Index(((1*4)+2), 40) ]))&&((int)now.light_enabled[ Index(((1*4)+3), 40) ]))&& !(((int)now.light_enabled[ Index(((2*4)+0), 40) ])))&& !(((int)now.light_enabled[ Index(((2*4)+1), 40) ])))&&((int)now.light_enabled[ Index(((2*4)+2), 40) ]))&&((int)now.light_enabled[ Index(((2*4)+3), 40) ]))&&((int)now.light_enabled[ Index(((3*4)+0), 40) ]))&&((int)now.light_enabled[ Index(((3*4)+1), 40) ]))&&((int)now.light_enabled[ Index(((3*4)+2), 40) ]))&& !(((int)now.light_enabled[ Index(((3*4)+3), 40) ])))&&((int)now.light_enabled[ Index(((4*4)+0), 40) ]))&&((int)now.light_enabled[ Index(((4*4)+1), 40) ]))&&((int)now.light_enabled[ Index(((4*4)+2), 40) ]))&&((int)now.light_enabled[ Index(((4*4)+3), 40) ]))&&((int)now.light_enabled[ Index(((5*4)+0), 40) ]))&& !(((int)now.light_enabled[ Index(((5*4)+1), 40) ])))&&((int)now.light_enabled[ Index(((5*4)+2), 40) ]))&&((int)now.light_enabled[ Index(((5*4)+3), 40) ]))&&((int)now.light_enabled[ Index(((6*4)+0), 40) ]))&&((int)now.light_enabled[ Index(((6*4)+1), 40) ]))&& !(((int)now.light_enabled[ Index(((6*4)+2), 40) ])))&& !(((int)now.light_enabled[ Index(((6*4)+3), 40) ])))&&((int)now.light_enabled[ Index(((7*4)+0), 40) ]))&&((int)now.light_enabled[ Index(((7*4)+1), 40) ]))&& !(((int)now.light_enabled[ Index(((7*4)+2), 40) ])))&&((int)now.light_enabled[ Index(((7*4)+3), 40) ]))&&((int)now.light_enabled[ Index(((8*4)+0), 40) ]))&& !(((int)now.light_enabled[ Index(((8*4)+1), 40) ])))&& !(((int)now.light_enabled[ Index(((8*4)+2), 40) ])))&&((int)now.light_enabled[ Index(((8*4)+3), 40) ]))))))
			continue;
		/* merge: assert(!(!((!(model_initialized)||(((((((((((((((((((((((((((((((((((!(light_enabled[((0*4)+0)])&&light_enabled[((0*4)+1)])&&light_enabled[((0*4)+2)])&&light_enabled[((0*4)+3)])&&!(light_enabled[((1*4)+0)]))&&light_enabled[((1*4)+1)])&&light_enabled[((1*4)+2)])&&light_enabled[((1*4)+3)])&&!(light_enabled[((2*4)+0)]))&&!(light_enabled[((2*4)+1)]))&&light_enabled[((2*4)+2)])&&light_enabled[((2*4)+3)])&&light_enabled[((3*4)+0)])&&light_enabled[((3*4)+1)])&&light_enabled[((3*4)+2)])&&!(light_enabled[((3*4)+3)]))&&light_enabled[((4*4)+0)])&&light_enabled[((4*4)+1)])&&light_enabled[((4*4)+2)])&&light_enabled[((4*4)+3)])&&light_enabled[((5*4)+0)])&&!(light_enabled[((5*4)+1)]))&&light_enabled[((5*4)+2)])&&light_enabled[((5*4)+3)])&&light_enabled[((6*4)+0)])&&light_enabled[((6*4)+1)])&&!(light_enabled[((6*4)+2)]))&&!(light_enabled[((6*4)+3)]))&&light_enabled[((7*4)+0)])&&light_enabled[((7*4)+1)])&&!(light_enabled[((7*4)+2)]))&&light_enabled[((7*4)+3)])&&light_enabled[((8*4)+0)])&&!(light_enabled[((8*4)+1)]))&&!(light_enabled[((8*4)+2)]))&&light_enabled[((8*4)+3)])))))(0, 2, 6) */
		reached[12][2] = 1;
		spin_assert( !( !(( !(((int)now.model_initialized))||((((((((((((((((((((((((((((((((((( !(((int)now.light_enabled[ Index(((0*4)+0), 40) ]))&&((int)now.light_enabled[ Index(((0*4)+1), 40) ]))&&((int)now.light_enabled[ Index(((0*4)+2), 40) ]))&&((int)now.light_enabled[ Index(((0*4)+3), 40) ]))&& !(((int)now.light_enabled[ Index(((1*4)+0), 40) ])))&&((int)now.light_enabled[ Index(((1*4)+1), 40) ]))&&((int)now.light_enabled[ Index(((1*4)+2), 40) ]))&&((int)now.light_enabled[ Index(((1*4)+3), 40) ]))&& !(((int)now.light_enabled[ Index(((2*4)+0), 40) ])))&& !(((int)now.light_enabled[ Index(((2*4)+1), 40) ])))&&((int)now.light_enabled[ Index(((2*4)+2), 40) ]))&&((int)now.light_enabled[ Index(((2*4)+3), 40) ]))&&((int)now.light_enabled[ Index(((3*4)+0), 40) ]))&&((int)now.light_enabled[ Index(((3*4)+1), 40) ]))&&((int)now.light_enabled[ Index(((3*4)+2), 40) ]))&& !(((int)now.light_enabled[ Index(((3*4)+3), 40) ])))&&((int)now.light_enabled[ Index(((4*4)+0), 40) ]))&&((int)now.light_enabled[ Index(((4*4)+1), 40) ]))&&((int)now.light_enabled[ Index(((4*4)+2), 40) ]))&&((int)now.light_enabled[ Index(((4*4)+3), 40) ]))&&((int)now.light_enabled[ Index(((5*4)+0), 40) ]))&& !(((int)now.light_enabled[ Index(((5*4)+1), 40) ])))&&((int)now.light_enabled[ Index(((5*4)+2), 40) ]))&&((int)now.light_enabled[ Index(((5*4)+3), 40) ]))&&((int)now.light_enabled[ Index(((6*4)+0), 40) ]))&&((int)now.light_enabled[ Index(((6*4)+1), 40) ]))&& !(((int)now.light_enabled[ Index(((6*4)+2), 40) ])))&& !(((int)now.light_enabled[ Index(((6*4)+3), 40) ])))&&((int)now.light_enabled[ Index(((7*4)+0), 40) ]))&&((int)now.light_enabled[ Index(((7*4)+1), 40) ]))&& !(((int)now.light_enabled[ Index(((7*4)+2), 40) ])))&&((int)now.light_enabled[ Index(((7*4)+3), 40) ]))&&((int)now.light_enabled[ Index(((8*4)+0), 40) ]))&& !(((int)now.light_enabled[ Index(((8*4)+1), 40) ])))&& !(((int)now.light_enabled[ Index(((8*4)+2), 40) ])))&&((int)now.light_enabled[ Index(((8*4)+3), 40) ]))))), " !( !(( !(model_initialized)||((((((((((((((((((((((((((((((((((( !(light_enabled[((0*4)+0)])&&light_enabled[((0*4)+1)])&&light_enabled[((0*4)+2)])&&light_enabled[((0*4)+3)])&& !(light_enabled[((1*4)+0)]))&&light_enabled[((1*4)+1)])&&light_enabled[((1*4)+2)])&&light_enabled[((1*4)+3)])&& !(light_enabled[((2*4)+0)]))&& !(light_enabled[((2*4)+1)]))&&light_enabled[((2*4)+2)])&&light_enabled[((2*4)+3)])&&light_enabled[((3*4)+0)])&&light_enabled[((3*4)+1)])&&light_enabled[((3*4)+2)])&& !(light_enabled[((3*4)+3)]))&&light_enabled[((4*4)+0)])&&light_enabled[((4*4)+1)])&&light_enabled[((4*4)+2)])&&light_enabled[((4*4)+3)])&&light_enabled[((5*4)+0)])&& !(light_enabled[((5*4)+1)]))&&light_enabled[((5*4)+2)])&&light_enabled[((5*4)+3)])&&light_enabled[((6*4)+0)])&&light_enabled[((6*4)+1)])&& !(light_enabled[((6*4)+2)]))&& !(light_enabled[((6*4)+3)]))&&light_enabled[((7*4)+0)])&&light_enabled[((7*4)+1)])&& !(light_enabled[((7*4)+2)]))&&light_enabled[((7*4)+3)])&&light_enabled[((8*4)+0)])&& !(light_enabled[((8*4)+1)]))&& !(light_enabled[((8*4)+2)]))&&light_enabled[((8*4)+3)]))))", II, tt, t);
		/* merge: .(goto)(0, 7, 6) */
		reached[12][7] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 4: // STATE 10 - _spin_nvr.tmp:85 - [-end-] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported10 = 0;
			if (verbose && !reported10)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported10 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported10 = 0;
			if (verbose && !reported10)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported10 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[12][10] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* CLAIM mutual_exclusion_lights */
	case 5: // STATE 1 - _spin_nvr.tmp:71 - [(!((!(model_initialized)||((((((((((light_green[0]<=3)&&light_enabled[((0*4)+light_green[0])])&&((light_green[1]<=3)&&light_enabled[((1*4)+light_green[1])]))&&((light_green[2]<=3)&&light_enabled[((2*4)+light_green[2])]))&&((light_green[3]<=3)&&light_enabled[((3*4)+light_green[3])]))&&((light_green[4]<=3)&&light_enabled[((4*4)+light_green[4])]))&&((light_green[5]<=3)&&light_enabled[((5*4)+light_green[5])]))&&((light_green[6]<=3)&&light_enabled[((6*4)+light_green[6])]))&&((light_green[7]<=3)&&light_enabled[((7*4)+light_green[7])]))&&((light_green[8]<=3)&&light_enabled[((8*4)+light_green[8])])))))] (6:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[11][1] = 1;
		if (!( !(( !(((int)now.model_initialized))||((((((((((((int)now.light_green[0])<=3)&&((int)now.light_enabled[ Index(((0*4)+((int)now.light_green[0])), 40) ]))&&((((int)now.light_green[1])<=3)&&((int)now.light_enabled[ Index(((1*4)+((int)now.light_green[1])), 40) ])))&&((((int)now.light_green[2])<=3)&&((int)now.light_enabled[ Index(((2*4)+((int)now.light_green[2])), 40) ])))&&((((int)now.light_green[3])<=3)&&((int)now.light_enabled[ Index(((3*4)+((int)now.light_green[3])), 40) ])))&&((((int)now.light_green[4])<=3)&&((int)now.light_enabled[ Index(((4*4)+((int)now.light_green[4])), 40) ])))&&((((int)now.light_green[5])<=3)&&((int)now.light_enabled[ Index(((5*4)+((int)now.light_green[5])), 40) ])))&&((((int)now.light_green[6])<=3)&&((int)now.light_enabled[ Index(((6*4)+((int)now.light_green[6])), 40) ])))&&((((int)now.light_green[7])<=3)&&((int)now.light_enabled[ Index(((7*4)+((int)now.light_green[7])), 40) ])))&&((((int)now.light_green[8])<=3)&&((int)now.light_enabled[ Index(((8*4)+((int)now.light_green[8])), 40) ])))))))
			continue;
		/* merge: assert(!(!((!(model_initialized)||((((((((((light_green[0]<=3)&&light_enabled[((0*4)+light_green[0])])&&((light_green[1]<=3)&&light_enabled[((1*4)+light_green[1])]))&&((light_green[2]<=3)&&light_enabled[((2*4)+light_green[2])]))&&((light_green[3]<=3)&&light_enabled[((3*4)+light_green[3])]))&&((light_green[4]<=3)&&light_enabled[((4*4)+light_green[4])]))&&((light_green[5]<=3)&&light_enabled[((5*4)+light_green[5])]))&&((light_green[6]<=3)&&light_enabled[((6*4)+light_green[6])]))&&((light_green[7]<=3)&&light_enabled[((7*4)+light_green[7])]))&&((light_green[8]<=3)&&light_enabled[((8*4)+light_green[8])]))))))(0, 2, 6) */
		reached[11][2] = 1;
		spin_assert( !( !(( !(((int)now.model_initialized))||((((((((((((int)now.light_green[0])<=3)&&((int)now.light_enabled[ Index(((0*4)+((int)now.light_green[0])), 40) ]))&&((((int)now.light_green[1])<=3)&&((int)now.light_enabled[ Index(((1*4)+((int)now.light_green[1])), 40) ])))&&((((int)now.light_green[2])<=3)&&((int)now.light_enabled[ Index(((2*4)+((int)now.light_green[2])), 40) ])))&&((((int)now.light_green[3])<=3)&&((int)now.light_enabled[ Index(((3*4)+((int)now.light_green[3])), 40) ])))&&((((int)now.light_green[4])<=3)&&((int)now.light_enabled[ Index(((4*4)+((int)now.light_green[4])), 40) ])))&&((((int)now.light_green[5])<=3)&&((int)now.light_enabled[ Index(((5*4)+((int)now.light_green[5])), 40) ])))&&((((int)now.light_green[6])<=3)&&((int)now.light_enabled[ Index(((6*4)+((int)now.light_green[6])), 40) ])))&&((((int)now.light_green[7])<=3)&&((int)now.light_enabled[ Index(((7*4)+((int)now.light_green[7])), 40) ])))&&((((int)now.light_green[8])<=3)&&((int)now.light_enabled[ Index(((8*4)+((int)now.light_green[8])), 40) ])))))), " !( !(( !(model_initialized)||((((((((((light_green[0]<=3)&&light_enabled[((0*4)+light_green[0])])&&((light_green[1]<=3)&&light_enabled[((1*4)+light_green[1])]))&&((light_green[2]<=3)&&light_enabled[((2*4)+light_green[2])]))&&((light_green[3]<=3)&&light_enabled[((3*4)+light_green[3])]))&&((light_green[4]<=3)&&light_enabled[((4*4)+light_green[4])]))&&((light_green[5]<=3)&&light_enabled[((5*4)+light_green[5])]))&&((light_green[6]<=3)&&light_enabled[((6*4)+light_green[6])]))&&((light_green[7]<=3)&&light_enabled[((7*4)+light_green[7])]))&&((light_green[8]<=3)&&light_enabled[((8*4)+light_green[8])])))))", II, tt, t);
		/* merge: .(goto)(0, 7, 6) */
		reached[11][7] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 6: // STATE 10 - _spin_nvr.tmp:76 - [-end-] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported10 = 0;
			if (verbose && !reported10)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported10 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported10 = 0;
			if (verbose && !reported10)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported10 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[11][10] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* CLAIM fair_green_bounded */
	case 7: // STATE 1 - _spin_nvr.tmp:62 - [(!((!(model_initialized)||(((((((((((((((((((((((((red_streak[((0*4)+1)]<=5)&&(red_streak[((0*4)+2)]<=5))&&(red_streak[((0*4)+3)]<=5))&&(red_streak[((1*4)+1)]<=5))&&(red_streak[((1*4)+2)]<=5))&&(red_streak[((1*4)+3)]<=5))&&(red_streak[((2*4)+2)]<=4))&&(red_streak[((2*4)+3)]<=4))&&(red_streak[((3*4)+0)]<=5))&&(red_streak[((3*4)+1)]<=5))&&(red_streak[((3*4)+2)]<=5))&&(red_streak[((4*4)+0)]<=6))&&(red_streak[((4*4)+1)]<=6))&&(red_streak[((4*4)+2)]<=6))&&(red_streak[((4*4)+3)]<=6))&&(red_streak[((5*4)+0)]<=5))&&(red_streak[((5*4)+2)]<=5))&&(red_streak[((5*4)+3)]<=5))&&(red_streak[((6*4)+0)]<=4))&&(red_streak[((6*4)+1)]<=4))&&(red_streak[((7*4)+0)]<=5))&&(red_streak[((7*4)+1)]<=5))&&(red_streak[((7*4)+3)]<=5))&&(red_streak[((8*4)+0)]<=4))&&(red_streak[((8*4)+3)]<=4)))))] (6:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[10][1] = 1;
		if (!( !(( !(((int)now.model_initialized))||(((((((((((((((((((((((((((int)now.red_streak[ Index(((0*4)+1), 40) ])<=5)&&(((int)now.red_streak[ Index(((0*4)+2), 40) ])<=5))&&(((int)now.red_streak[ Index(((0*4)+3), 40) ])<=5))&&(((int)now.red_streak[ Index(((1*4)+1), 40) ])<=5))&&(((int)now.red_streak[ Index(((1*4)+2), 40) ])<=5))&&(((int)now.red_streak[ Index(((1*4)+3), 40) ])<=5))&&(((int)now.red_streak[ Index(((2*4)+2), 40) ])<=4))&&(((int)now.red_streak[ Index(((2*4)+3), 40) ])<=4))&&(((int)now.red_streak[ Index(((3*4)+0), 40) ])<=5))&&(((int)now.red_streak[ Index(((3*4)+1), 40) ])<=5))&&(((int)now.red_streak[ Index(((3*4)+2), 40) ])<=5))&&(((int)now.red_streak[ Index(((4*4)+0), 40) ])<=6))&&(((int)now.red_streak[ Index(((4*4)+1), 40) ])<=6))&&(((int)now.red_streak[ Index(((4*4)+2), 40) ])<=6))&&(((int)now.red_streak[ Index(((4*4)+3), 40) ])<=6))&&(((int)now.red_streak[ Index(((5*4)+0), 40) ])<=5))&&(((int)now.red_streak[ Index(((5*4)+2), 40) ])<=5))&&(((int)now.red_streak[ Index(((5*4)+3), 40) ])<=5))&&(((int)now.red_streak[ Index(((6*4)+0), 40) ])<=4))&&(((int)now.red_streak[ Index(((6*4)+1), 40) ])<=4))&&(((int)now.red_streak[ Index(((7*4)+0), 40) ])<=5))&&(((int)now.red_streak[ Index(((7*4)+1), 40) ])<=5))&&(((int)now.red_streak[ Index(((7*4)+3), 40) ])<=5))&&(((int)now.red_streak[ Index(((8*4)+0), 40) ])<=4))&&(((int)now.red_streak[ Index(((8*4)+3), 40) ])<=4))))))
			continue;
		/* merge: assert(!(!((!(model_initialized)||(((((((((((((((((((((((((red_streak[((0*4)+1)]<=5)&&(red_streak[((0*4)+2)]<=5))&&(red_streak[((0*4)+3)]<=5))&&(red_streak[((1*4)+1)]<=5))&&(red_streak[((1*4)+2)]<=5))&&(red_streak[((1*4)+3)]<=5))&&(red_streak[((2*4)+2)]<=4))&&(red_streak[((2*4)+3)]<=4))&&(red_streak[((3*4)+0)]<=5))&&(red_streak[((3*4)+1)]<=5))&&(red_streak[((3*4)+2)]<=5))&&(red_streak[((4*4)+0)]<=6))&&(red_streak[((4*4)+1)]<=6))&&(red_streak[((4*4)+2)]<=6))&&(red_streak[((4*4)+3)]<=6))&&(red_streak[((5*4)+0)]<=5))&&(red_streak[((5*4)+2)]<=5))&&(red_streak[((5*4)+3)]<=5))&&(red_streak[((6*4)+0)]<=4))&&(red_streak[((6*4)+1)]<=4))&&(red_streak[((7*4)+0)]<=5))&&(red_streak[((7*4)+1)]<=5))&&(red_streak[((7*4)+3)]<=5))&&(red_streak[((8*4)+0)]<=4))&&(red_streak[((8*4)+3)]<=4))))))(0, 2, 6) */
		reached[10][2] = 1;
		spin_assert( !( !(( !(((int)now.model_initialized))||(((((((((((((((((((((((((((int)now.red_streak[ Index(((0*4)+1), 40) ])<=5)&&(((int)now.red_streak[ Index(((0*4)+2), 40) ])<=5))&&(((int)now.red_streak[ Index(((0*4)+3), 40) ])<=5))&&(((int)now.red_streak[ Index(((1*4)+1), 40) ])<=5))&&(((int)now.red_streak[ Index(((1*4)+2), 40) ])<=5))&&(((int)now.red_streak[ Index(((1*4)+3), 40) ])<=5))&&(((int)now.red_streak[ Index(((2*4)+2), 40) ])<=4))&&(((int)now.red_streak[ Index(((2*4)+3), 40) ])<=4))&&(((int)now.red_streak[ Index(((3*4)+0), 40) ])<=5))&&(((int)now.red_streak[ Index(((3*4)+1), 40) ])<=5))&&(((int)now.red_streak[ Index(((3*4)+2), 40) ])<=5))&&(((int)now.red_streak[ Index(((4*4)+0), 40) ])<=6))&&(((int)now.red_streak[ Index(((4*4)+1), 40) ])<=6))&&(((int)now.red_streak[ Index(((4*4)+2), 40) ])<=6))&&(((int)now.red_streak[ Index(((4*4)+3), 40) ])<=6))&&(((int)now.red_streak[ Index(((5*4)+0), 40) ])<=5))&&(((int)now.red_streak[ Index(((5*4)+2), 40) ])<=5))&&(((int)now.red_streak[ Index(((5*4)+3), 40) ])<=5))&&(((int)now.red_streak[ Index(((6*4)+0), 40) ])<=4))&&(((int)now.red_streak[ Index(((6*4)+1), 40) ])<=4))&&(((int)now.red_streak[ Index(((7*4)+0), 40) ])<=5))&&(((int)now.red_streak[ Index(((7*4)+1), 40) ])<=5))&&(((int)now.red_streak[ Index(((7*4)+3), 40) ])<=5))&&(((int)now.red_streak[ Index(((8*4)+0), 40) ])<=4))&&(((int)now.red_streak[ Index(((8*4)+3), 40) ])<=4))))), " !( !(( !(model_initialized)||(((((((((((((((((((((((((red_streak[((0*4)+1)]<=5)&&(red_streak[((0*4)+2)]<=5))&&(red_streak[((0*4)+3)]<=5))&&(red_streak[((1*4)+1)]<=5))&&(red_streak[((1*4)+2)]<=5))&&(red_streak[((1*4)+3)]<=5))&&(red_streak[((2*4)+2)]<=4))&&(red_streak[((2*4)+3)]<=4))&&(red_streak[((3*4)+0)]<=5))&&(red_streak[((3*4)+1)]<=5))&&(red_streak[((3*4)+2)]<=5))&&(red_streak[((4*4)+0)]<=6))&&(red_streak[((4*4)+1)]<=6))&&(red_streak[((4*4)+2)]<=6))&&(red_streak[((4*4)+3)]<=6))&&(red_streak[((5*4)+0)]<=5))&&(red_streak[((5*4)+2)]<=5))&&(red_streak[((5*4)+3)]<=5))&&(red_streak[((6*4)+0)]<=4))&&(red_streak[((6*4)+1)]<=4))&&(red_streak[((7*4)+0)]<=5))&&(red_streak[((7*4)+1)]<=5))&&(red_streak[((7*4)+3)]<=5))&&(red_streak[((8*4)+0)]<=4))&&(red_streak[((8*4)+3)]<=4)))))", II, tt, t);
		/* merge: .(goto)(0, 7, 6) */
		reached[10][7] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 8: // STATE 10 - _spin_nvr.tmp:67 - [-end-] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported10 = 0;
			if (verbose && !reported10)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported10 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported10 = 0;
			if (verbose && !reported10)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported10 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[10][10] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* CLAIM eventual_green_bounded */
	case 9: // STATE 1 - _spin_nvr.tmp:53 - [(!((!(model_initialized)||(((((((((((((((((((((((((red_streak[((0*4)+1)]<=5)&&(red_streak[((0*4)+2)]<=5))&&(red_streak[((0*4)+3)]<=5))&&(red_streak[((1*4)+1)]<=5))&&(red_streak[((1*4)+2)]<=5))&&(red_streak[((1*4)+3)]<=5))&&(red_streak[((2*4)+2)]<=4))&&(red_streak[((2*4)+3)]<=4))&&(red_streak[((3*4)+0)]<=5))&&(red_streak[((3*4)+1)]<=5))&&(red_streak[((3*4)+2)]<=5))&&(red_streak[((4*4)+0)]<=6))&&(red_streak[((4*4)+1)]<=6))&&(red_streak[((4*4)+2)]<=6))&&(red_streak[((4*4)+3)]<=6))&&(red_streak[((5*4)+0)]<=5))&&(red_streak[((5*4)+2)]<=5))&&(red_streak[((5*4)+3)]<=5))&&(red_streak[((6*4)+0)]<=4))&&(red_streak[((6*4)+1)]<=4))&&(red_streak[((7*4)+0)]<=5))&&(red_streak[((7*4)+1)]<=5))&&(red_streak[((7*4)+3)]<=5))&&(red_streak[((8*4)+0)]<=4))&&(red_streak[((8*4)+3)]<=4)))))] (6:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[9][1] = 1;
		if (!( !(( !(((int)now.model_initialized))||(((((((((((((((((((((((((((int)now.red_streak[ Index(((0*4)+1), 40) ])<=5)&&(((int)now.red_streak[ Index(((0*4)+2), 40) ])<=5))&&(((int)now.red_streak[ Index(((0*4)+3), 40) ])<=5))&&(((int)now.red_streak[ Index(((1*4)+1), 40) ])<=5))&&(((int)now.red_streak[ Index(((1*4)+2), 40) ])<=5))&&(((int)now.red_streak[ Index(((1*4)+3), 40) ])<=5))&&(((int)now.red_streak[ Index(((2*4)+2), 40) ])<=4))&&(((int)now.red_streak[ Index(((2*4)+3), 40) ])<=4))&&(((int)now.red_streak[ Index(((3*4)+0), 40) ])<=5))&&(((int)now.red_streak[ Index(((3*4)+1), 40) ])<=5))&&(((int)now.red_streak[ Index(((3*4)+2), 40) ])<=5))&&(((int)now.red_streak[ Index(((4*4)+0), 40) ])<=6))&&(((int)now.red_streak[ Index(((4*4)+1), 40) ])<=6))&&(((int)now.red_streak[ Index(((4*4)+2), 40) ])<=6))&&(((int)now.red_streak[ Index(((4*4)+3), 40) ])<=6))&&(((int)now.red_streak[ Index(((5*4)+0), 40) ])<=5))&&(((int)now.red_streak[ Index(((5*4)+2), 40) ])<=5))&&(((int)now.red_streak[ Index(((5*4)+3), 40) ])<=5))&&(((int)now.red_streak[ Index(((6*4)+0), 40) ])<=4))&&(((int)now.red_streak[ Index(((6*4)+1), 40) ])<=4))&&(((int)now.red_streak[ Index(((7*4)+0), 40) ])<=5))&&(((int)now.red_streak[ Index(((7*4)+1), 40) ])<=5))&&(((int)now.red_streak[ Index(((7*4)+3), 40) ])<=5))&&(((int)now.red_streak[ Index(((8*4)+0), 40) ])<=4))&&(((int)now.red_streak[ Index(((8*4)+3), 40) ])<=4))))))
			continue;
		/* merge: assert(!(!((!(model_initialized)||(((((((((((((((((((((((((red_streak[((0*4)+1)]<=5)&&(red_streak[((0*4)+2)]<=5))&&(red_streak[((0*4)+3)]<=5))&&(red_streak[((1*4)+1)]<=5))&&(red_streak[((1*4)+2)]<=5))&&(red_streak[((1*4)+3)]<=5))&&(red_streak[((2*4)+2)]<=4))&&(red_streak[((2*4)+3)]<=4))&&(red_streak[((3*4)+0)]<=5))&&(red_streak[((3*4)+1)]<=5))&&(red_streak[((3*4)+2)]<=5))&&(red_streak[((4*4)+0)]<=6))&&(red_streak[((4*4)+1)]<=6))&&(red_streak[((4*4)+2)]<=6))&&(red_streak[((4*4)+3)]<=6))&&(red_streak[((5*4)+0)]<=5))&&(red_streak[((5*4)+2)]<=5))&&(red_streak[((5*4)+3)]<=5))&&(red_streak[((6*4)+0)]<=4))&&(red_streak[((6*4)+1)]<=4))&&(red_streak[((7*4)+0)]<=5))&&(red_streak[((7*4)+1)]<=5))&&(red_streak[((7*4)+3)]<=5))&&(red_streak[((8*4)+0)]<=4))&&(red_streak[((8*4)+3)]<=4))))))(0, 2, 6) */
		reached[9][2] = 1;
		spin_assert( !( !(( !(((int)now.model_initialized))||(((((((((((((((((((((((((((int)now.red_streak[ Index(((0*4)+1), 40) ])<=5)&&(((int)now.red_streak[ Index(((0*4)+2), 40) ])<=5))&&(((int)now.red_streak[ Index(((0*4)+3), 40) ])<=5))&&(((int)now.red_streak[ Index(((1*4)+1), 40) ])<=5))&&(((int)now.red_streak[ Index(((1*4)+2), 40) ])<=5))&&(((int)now.red_streak[ Index(((1*4)+3), 40) ])<=5))&&(((int)now.red_streak[ Index(((2*4)+2), 40) ])<=4))&&(((int)now.red_streak[ Index(((2*4)+3), 40) ])<=4))&&(((int)now.red_streak[ Index(((3*4)+0), 40) ])<=5))&&(((int)now.red_streak[ Index(((3*4)+1), 40) ])<=5))&&(((int)now.red_streak[ Index(((3*4)+2), 40) ])<=5))&&(((int)now.red_streak[ Index(((4*4)+0), 40) ])<=6))&&(((int)now.red_streak[ Index(((4*4)+1), 40) ])<=6))&&(((int)now.red_streak[ Index(((4*4)+2), 40) ])<=6))&&(((int)now.red_streak[ Index(((4*4)+3), 40) ])<=6))&&(((int)now.red_streak[ Index(((5*4)+0), 40) ])<=5))&&(((int)now.red_streak[ Index(((5*4)+2), 40) ])<=5))&&(((int)now.red_streak[ Index(((5*4)+3), 40) ])<=5))&&(((int)now.red_streak[ Index(((6*4)+0), 40) ])<=4))&&(((int)now.red_streak[ Index(((6*4)+1), 40) ])<=4))&&(((int)now.red_streak[ Index(((7*4)+0), 40) ])<=5))&&(((int)now.red_streak[ Index(((7*4)+1), 40) ])<=5))&&(((int)now.red_streak[ Index(((7*4)+3), 40) ])<=5))&&(((int)now.red_streak[ Index(((8*4)+0), 40) ])<=4))&&(((int)now.red_streak[ Index(((8*4)+3), 40) ])<=4))))), " !( !(( !(model_initialized)||(((((((((((((((((((((((((red_streak[((0*4)+1)]<=5)&&(red_streak[((0*4)+2)]<=5))&&(red_streak[((0*4)+3)]<=5))&&(red_streak[((1*4)+1)]<=5))&&(red_streak[((1*4)+2)]<=5))&&(red_streak[((1*4)+3)]<=5))&&(red_streak[((2*4)+2)]<=4))&&(red_streak[((2*4)+3)]<=4))&&(red_streak[((3*4)+0)]<=5))&&(red_streak[((3*4)+1)]<=5))&&(red_streak[((3*4)+2)]<=5))&&(red_streak[((4*4)+0)]<=6))&&(red_streak[((4*4)+1)]<=6))&&(red_streak[((4*4)+2)]<=6))&&(red_streak[((4*4)+3)]<=6))&&(red_streak[((5*4)+0)]<=5))&&(red_streak[((5*4)+2)]<=5))&&(red_streak[((5*4)+3)]<=5))&&(red_streak[((6*4)+0)]<=4))&&(red_streak[((6*4)+1)]<=4))&&(red_streak[((7*4)+0)]<=5))&&(red_streak[((7*4)+1)]<=5))&&(red_streak[((7*4)+3)]<=5))&&(red_streak[((8*4)+0)]<=4))&&(red_streak[((8*4)+3)]<=4)))))", II, tt, t);
		/* merge: .(goto)(0, 7, 6) */
		reached[9][7] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 10: // STATE 10 - _spin_nvr.tmp:58 - [-end-] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported10 = 0;
			if (verbose && !reported10)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported10 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported10 = 0;
			if (verbose && !reported10)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported10 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[9][10] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* CLAIM tour_closure */
	case 11: // STATE 1 - _spin_nvr.tmp:47 - [(!((returned_A[0]&&returned_A[1])))] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[8][1] = 1;
		if (!( !((((int)now.returned_A[0])&&((int)now.returned_A[1])))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 12: // STATE 6 - _spin_nvr.tmp:49 - [-end-] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported6 = 0;
			if (verbose && !reported6)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported6 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported6 = 0;
			if (verbose && !reported6)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported6 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[8][6] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* CLAIM visit_all_bcd */
	case 13: // STATE 1 - _spin_nvr.tmp:40 - [(!((((((visited_B[0]&&visited_C[0])&&visited_D[0])&&visited_B[1])&&visited_C[1])&&visited_D[1])))] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[7][1] = 1;
		if (!( !((((((((int)now.visited_B[0])&&((int)now.visited_C[0]))&&((int)now.visited_D[0]))&&((int)now.visited_B[1]))&&((int)now.visited_C[1]))&&((int)now.visited_D[1])))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 14: // STATE 6 - _spin_nvr.tmp:42 - [-end-] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported6 = 0;
			if (verbose && !reported6)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported6 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported6 = 0;
			if (verbose && !reported6)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported6 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[7][6] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* CLAIM no_uturn */
	case 15: // STATE 1 - _spin_nvr.tmp:30 - [(!(!(uturn_violation)))] (6:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[6][1] = 1;
		if (!( !( !(((int)now.uturn_violation)))))
			continue;
		/* merge: assert(!(!(!(uturn_violation))))(0, 2, 6) */
		reached[6][2] = 1;
		spin_assert( !( !( !(((int)now.uturn_violation)))), " !( !( !(uturn_violation)))", II, tt, t);
		/* merge: .(goto)(0, 7, 6) */
		reached[6][7] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 16: // STATE 10 - _spin_nvr.tmp:35 - [-end-] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported10 = 0;
			if (verbose && !reported10)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported10 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported10 = 0;
			if (verbose && !reported10)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported10 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[6][10] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* CLAIM no_opposite_direction */
	case 17: // STATE 1 - _spin_nvr.tmp:21 - [(!(!(opposite_direction_violation)))] (6:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[5][1] = 1;
		if (!( !( !(((int)now.opposite_direction_violation)))))
			continue;
		/* merge: assert(!(!(!(opposite_direction_violation))))(0, 2, 6) */
		reached[5][2] = 1;
		spin_assert( !( !( !(((int)now.opposite_direction_violation)))), " !( !( !(opposite_direction_violation)))", II, tt, t);
		/* merge: .(goto)(0, 7, 6) */
		reached[5][7] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 18: // STATE 10 - _spin_nvr.tmp:26 - [-end-] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported10 = 0;
			if (verbose && !reported10)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported10 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported10 = 0;
			if (verbose && !reported10)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported10 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[5][10] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* CLAIM no_red_violation */
	case 19: // STATE 1 - _spin_nvr.tmp:12 - [(!(!(red_violation)))] (6:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[4][1] = 1;
		if (!( !( !(((int)now.red_violation)))))
			continue;
		/* merge: assert(!(!(!(red_violation))))(0, 2, 6) */
		reached[4][2] = 1;
		spin_assert( !( !( !(((int)now.red_violation)))), " !( !( !(red_violation)))", II, tt, t);
		/* merge: .(goto)(0, 7, 6) */
		reached[4][7] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 20: // STATE 10 - _spin_nvr.tmp:17 - [-end-] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported10 = 0;
			if (verbose && !reported10)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported10 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported10 = 0;
			if (verbose && !reported10)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported10 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[4][10] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* CLAIM no_collision */
	case 21: // STATE 1 - _spin_nvr.tmp:3 - [(!(!(collision)))] (6:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[3][1] = 1;
		if (!( !( !(((int)now.collision)))))
			continue;
		/* merge: assert(!(!(!(collision))))(0, 2, 6) */
		reached[3][2] = 1;
		spin_assert( !( !( !(((int)now.collision)))), " !( !( !(collision)))", II, tt, t);
		/* merge: .(goto)(0, 7, 6) */
		reached[3][7] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 22: // STATE 10 - _spin_nvr.tmp:8 - [-end-] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported10 = 0;
			if (verbose && !reported10)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported10 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported10 = 0;
			if (verbose && !reported10)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported10 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[3][10] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC :init: */
	case 23: // STATE 1 - phase_c_model.pml:822 - [i = 0] (0:0:1 - 1)
		IfNotBlocked
		reached[2][1] = 1;
		(trpt+1)->bup.oval = ((int)((P2 *)_this)->i);
		((P2 *)_this)->i = 0;
#ifdef VAR_RANGES
		logval(":init::i", ((int)((P2 *)_this)->i));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 24: // STATE 2 - phase_c_model.pml:824 - [((i<(10*4)))] (7:0:2 - 1)
		IfNotBlocked
		reached[2][2] = 1;
		if (!((((int)((P2 *)_this)->i)<(10*4))))
			continue;
		/* merge: light_enabled[i] = 0(7, 3, 7) */
		reached[2][3] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = ((int)now.light_enabled[ Index(((int)((P2 *)_this)->i), 40) ]);
		now.light_enabled[ Index(((P2 *)_this)->i, 40) ] = 0;
#ifdef VAR_RANGES
		logval("light_enabled[:init::i]", ((int)now.light_enabled[ Index(((int)((P2 *)_this)->i), 40) ]));
#endif
		;
		/* merge: i = (i+1)(7, 4, 7) */
		reached[2][4] = 1;
		(trpt+1)->bup.ovals[1] = ((int)((P2 *)_this)->i);
		((P2 *)_this)->i = (((int)((P2 *)_this)->i)+1);
#ifdef VAR_RANGES
		logval(":init::i", ((int)((P2 *)_this)->i));
#endif
		;
		/* merge: .(goto)(0, 8, 7) */
		reached[2][8] = 1;
		;
		_m = 3; goto P999; /* 3 */
	case 25: // STATE 5 - phase_c_model.pml:825 - [((i>=(10*4)))] (52:0:38 - 1)
		IfNotBlocked
		reached[2][5] = 1;
		if (!((((int)((P2 *)_this)->i)>=(10*4))))
			continue;
		if (TstOnly) return 1; /* TT */
		/* dead 1: i */  (trpt+1)->bup.ovals = grab_ints(38);
		(trpt+1)->bup.ovals[0] = ((P2 *)_this)->i;
#ifdef HAS_CODE
		if (!readtrail)
#endif
			((P2 *)_this)->i = 0;
		/* merge: goto :b11(52, 6, 52) */
		reached[2][6] = 1;
		;
		/* merge: light_enabled[((0*4)+1)] = 1(52, 10, 52) */
		reached[2][10] = 1;
		(trpt+1)->bup.ovals[1] = ((int)now.light_enabled[ Index(((0*4)+1), 40) ]);
		now.light_enabled[ Index(((0*4)+1), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((0*4)+1)]", ((int)now.light_enabled[ Index(((0*4)+1), 40) ]));
#endif
		;
		/* merge: light_enabled[((0*4)+2)] = 1(52, 11, 52) */
		reached[2][11] = 1;
		(trpt+1)->bup.ovals[2] = ((int)now.light_enabled[ Index(((0*4)+2), 40) ]);
		now.light_enabled[ Index(((0*4)+2), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((0*4)+2)]", ((int)now.light_enabled[ Index(((0*4)+2), 40) ]));
#endif
		;
		/* merge: light_enabled[((0*4)+3)] = 1(52, 12, 52) */
		reached[2][12] = 1;
		(trpt+1)->bup.ovals[3] = ((int)now.light_enabled[ Index(((0*4)+3), 40) ]);
		now.light_enabled[ Index(((0*4)+3), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((0*4)+3)]", ((int)now.light_enabled[ Index(((0*4)+3), 40) ]));
#endif
		;
		/* merge: light_enabled[((1*4)+1)] = 1(52, 13, 52) */
		reached[2][13] = 1;
		(trpt+1)->bup.ovals[4] = ((int)now.light_enabled[ Index(((1*4)+1), 40) ]);
		now.light_enabled[ Index(((1*4)+1), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((1*4)+1)]", ((int)now.light_enabled[ Index(((1*4)+1), 40) ]));
#endif
		;
		/* merge: light_enabled[((1*4)+2)] = 1(52, 14, 52) */
		reached[2][14] = 1;
		(trpt+1)->bup.ovals[5] = ((int)now.light_enabled[ Index(((1*4)+2), 40) ]);
		now.light_enabled[ Index(((1*4)+2), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((1*4)+2)]", ((int)now.light_enabled[ Index(((1*4)+2), 40) ]));
#endif
		;
		/* merge: light_enabled[((1*4)+3)] = 1(52, 15, 52) */
		reached[2][15] = 1;
		(trpt+1)->bup.ovals[6] = ((int)now.light_enabled[ Index(((1*4)+3), 40) ]);
		now.light_enabled[ Index(((1*4)+3), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((1*4)+3)]", ((int)now.light_enabled[ Index(((1*4)+3), 40) ]));
#endif
		;
		/* merge: light_enabled[((2*4)+2)] = 1(52, 16, 52) */
		reached[2][16] = 1;
		(trpt+1)->bup.ovals[7] = ((int)now.light_enabled[ Index(((2*4)+2), 40) ]);
		now.light_enabled[ Index(((2*4)+2), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((2*4)+2)]", ((int)now.light_enabled[ Index(((2*4)+2), 40) ]));
#endif
		;
		/* merge: light_enabled[((2*4)+3)] = 1(52, 17, 52) */
		reached[2][17] = 1;
		(trpt+1)->bup.ovals[8] = ((int)now.light_enabled[ Index(((2*4)+3), 40) ]);
		now.light_enabled[ Index(((2*4)+3), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((2*4)+3)]", ((int)now.light_enabled[ Index(((2*4)+3), 40) ]));
#endif
		;
		/* merge: light_enabled[((3*4)+0)] = 1(52, 18, 52) */
		reached[2][18] = 1;
		(trpt+1)->bup.ovals[9] = ((int)now.light_enabled[ Index(((3*4)+0), 40) ]);
		now.light_enabled[ Index(((3*4)+0), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((3*4)+0)]", ((int)now.light_enabled[ Index(((3*4)+0), 40) ]));
#endif
		;
		/* merge: light_enabled[((3*4)+1)] = 1(52, 19, 52) */
		reached[2][19] = 1;
		(trpt+1)->bup.ovals[10] = ((int)now.light_enabled[ Index(((3*4)+1), 40) ]);
		now.light_enabled[ Index(((3*4)+1), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((3*4)+1)]", ((int)now.light_enabled[ Index(((3*4)+1), 40) ]));
#endif
		;
		/* merge: light_enabled[((3*4)+2)] = 1(52, 20, 52) */
		reached[2][20] = 1;
		(trpt+1)->bup.ovals[11] = ((int)now.light_enabled[ Index(((3*4)+2), 40) ]);
		now.light_enabled[ Index(((3*4)+2), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((3*4)+2)]", ((int)now.light_enabled[ Index(((3*4)+2), 40) ]));
#endif
		;
		/* merge: light_enabled[((4*4)+0)] = 1(52, 21, 52) */
		reached[2][21] = 1;
		(trpt+1)->bup.ovals[12] = ((int)now.light_enabled[ Index(((4*4)+0), 40) ]);
		now.light_enabled[ Index(((4*4)+0), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((4*4)+0)]", ((int)now.light_enabled[ Index(((4*4)+0), 40) ]));
#endif
		;
		/* merge: light_enabled[((4*4)+1)] = 1(52, 22, 52) */
		reached[2][22] = 1;
		(trpt+1)->bup.ovals[13] = ((int)now.light_enabled[ Index(((4*4)+1), 40) ]);
		now.light_enabled[ Index(((4*4)+1), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((4*4)+1)]", ((int)now.light_enabled[ Index(((4*4)+1), 40) ]));
#endif
		;
		/* merge: light_enabled[((4*4)+2)] = 1(52, 23, 52) */
		reached[2][23] = 1;
		(trpt+1)->bup.ovals[14] = ((int)now.light_enabled[ Index(((4*4)+2), 40) ]);
		now.light_enabled[ Index(((4*4)+2), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((4*4)+2)]", ((int)now.light_enabled[ Index(((4*4)+2), 40) ]));
#endif
		;
		/* merge: light_enabled[((4*4)+3)] = 1(52, 24, 52) */
		reached[2][24] = 1;
		(trpt+1)->bup.ovals[15] = ((int)now.light_enabled[ Index(((4*4)+3), 40) ]);
		now.light_enabled[ Index(((4*4)+3), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((4*4)+3)]", ((int)now.light_enabled[ Index(((4*4)+3), 40) ]));
#endif
		;
		/* merge: light_enabled[((5*4)+0)] = 1(52, 25, 52) */
		reached[2][25] = 1;
		(trpt+1)->bup.ovals[16] = ((int)now.light_enabled[ Index(((5*4)+0), 40) ]);
		now.light_enabled[ Index(((5*4)+0), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((5*4)+0)]", ((int)now.light_enabled[ Index(((5*4)+0), 40) ]));
#endif
		;
		/* merge: light_enabled[((5*4)+2)] = 1(52, 26, 52) */
		reached[2][26] = 1;
		(trpt+1)->bup.ovals[17] = ((int)now.light_enabled[ Index(((5*4)+2), 40) ]);
		now.light_enabled[ Index(((5*4)+2), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((5*4)+2)]", ((int)now.light_enabled[ Index(((5*4)+2), 40) ]));
#endif
		;
		/* merge: light_enabled[((5*4)+3)] = 1(52, 27, 52) */
		reached[2][27] = 1;
		(trpt+1)->bup.ovals[18] = ((int)now.light_enabled[ Index(((5*4)+3), 40) ]);
		now.light_enabled[ Index(((5*4)+3), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((5*4)+3)]", ((int)now.light_enabled[ Index(((5*4)+3), 40) ]));
#endif
		;
		/* merge: light_enabled[((6*4)+0)] = 1(52, 28, 52) */
		reached[2][28] = 1;
		(trpt+1)->bup.ovals[19] = ((int)now.light_enabled[ Index(((6*4)+0), 40) ]);
		now.light_enabled[ Index(((6*4)+0), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((6*4)+0)]", ((int)now.light_enabled[ Index(((6*4)+0), 40) ]));
#endif
		;
		/* merge: light_enabled[((6*4)+1)] = 1(52, 29, 52) */
		reached[2][29] = 1;
		(trpt+1)->bup.ovals[20] = ((int)now.light_enabled[ Index(((6*4)+1), 40) ]);
		now.light_enabled[ Index(((6*4)+1), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((6*4)+1)]", ((int)now.light_enabled[ Index(((6*4)+1), 40) ]));
#endif
		;
		/* merge: light_enabled[((7*4)+0)] = 1(52, 30, 52) */
		reached[2][30] = 1;
		(trpt+1)->bup.ovals[21] = ((int)now.light_enabled[ Index(((7*4)+0), 40) ]);
		now.light_enabled[ Index(((7*4)+0), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((7*4)+0)]", ((int)now.light_enabled[ Index(((7*4)+0), 40) ]));
#endif
		;
		/* merge: light_enabled[((7*4)+1)] = 1(52, 31, 52) */
		reached[2][31] = 1;
		(trpt+1)->bup.ovals[22] = ((int)now.light_enabled[ Index(((7*4)+1), 40) ]);
		now.light_enabled[ Index(((7*4)+1), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((7*4)+1)]", ((int)now.light_enabled[ Index(((7*4)+1), 40) ]));
#endif
		;
		/* merge: light_enabled[((7*4)+3)] = 1(52, 32, 52) */
		reached[2][32] = 1;
		(trpt+1)->bup.ovals[23] = ((int)now.light_enabled[ Index(((7*4)+3), 40) ]);
		now.light_enabled[ Index(((7*4)+3), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((7*4)+3)]", ((int)now.light_enabled[ Index(((7*4)+3), 40) ]));
#endif
		;
		/* merge: light_enabled[((8*4)+0)] = 1(52, 33, 52) */
		reached[2][33] = 1;
		(trpt+1)->bup.ovals[24] = ((int)now.light_enabled[ Index(((8*4)+0), 40) ]);
		now.light_enabled[ Index(((8*4)+0), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((8*4)+0)]", ((int)now.light_enabled[ Index(((8*4)+0), 40) ]));
#endif
		;
		/* merge: light_enabled[((8*4)+3)] = 1(52, 34, 52) */
		reached[2][34] = 1;
		(trpt+1)->bup.ovals[25] = ((int)now.light_enabled[ Index(((8*4)+3), 40) ]);
		now.light_enabled[ Index(((8*4)+3), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((8*4)+3)]", ((int)now.light_enabled[ Index(((8*4)+3), 40) ]));
#endif
		;
		/* merge: light_enabled[((9*4)+1)] = 1(52, 35, 52) */
		reached[2][35] = 1;
		(trpt+1)->bup.ovals[26] = ((int)now.light_enabled[ Index(((9*4)+1), 40) ]);
		now.light_enabled[ Index(((9*4)+1), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((9*4)+1)]", ((int)now.light_enabled[ Index(((9*4)+1), 40) ]));
#endif
		;
		/* merge: light_green[0] = 1(52, 36, 52) */
		reached[2][36] = 1;
		(trpt+1)->bup.ovals[27] = ((int)now.light_green[0]);
		now.light_green[0] = 1;
#ifdef VAR_RANGES
		logval("light_green[0]", ((int)now.light_green[0]));
#endif
		;
		/* merge: light_green[1] = 1(52, 37, 52) */
		reached[2][37] = 1;
		(trpt+1)->bup.ovals[28] = ((int)now.light_green[1]);
		now.light_green[1] = 1;
#ifdef VAR_RANGES
		logval("light_green[1]", ((int)now.light_green[1]));
#endif
		;
		/* merge: light_green[2] = 2(52, 38, 52) */
		reached[2][38] = 1;
		(trpt+1)->bup.ovals[29] = ((int)now.light_green[2]);
		now.light_green[2] = 2;
#ifdef VAR_RANGES
		logval("light_green[2]", ((int)now.light_green[2]));
#endif
		;
		/* merge: light_green[3] = 0(52, 39, 52) */
		reached[2][39] = 1;
		(trpt+1)->bup.ovals[30] = ((int)now.light_green[3]);
		now.light_green[3] = 0;
#ifdef VAR_RANGES
		logval("light_green[3]", ((int)now.light_green[3]));
#endif
		;
		/* merge: light_green[4] = 0(52, 40, 52) */
		reached[2][40] = 1;
		(trpt+1)->bup.ovals[31] = ((int)now.light_green[4]);
		now.light_green[4] = 0;
#ifdef VAR_RANGES
		logval("light_green[4]", ((int)now.light_green[4]));
#endif
		;
		/* merge: light_green[5] = 0(52, 41, 52) */
		reached[2][41] = 1;
		(trpt+1)->bup.ovals[32] = ((int)now.light_green[5]);
		now.light_green[5] = 0;
#ifdef VAR_RANGES
		logval("light_green[5]", ((int)now.light_green[5]));
#endif
		;
		/* merge: light_green[6] = 0(52, 42, 52) */
		reached[2][42] = 1;
		(trpt+1)->bup.ovals[33] = ((int)now.light_green[6]);
		now.light_green[6] = 0;
#ifdef VAR_RANGES
		logval("light_green[6]", ((int)now.light_green[6]));
#endif
		;
		/* merge: light_green[7] = 0(52, 43, 52) */
		reached[2][43] = 1;
		(trpt+1)->bup.ovals[34] = ((int)now.light_green[7]);
		now.light_green[7] = 0;
#ifdef VAR_RANGES
		logval("light_green[7]", ((int)now.light_green[7]));
#endif
		;
		/* merge: light_green[8] = 0(52, 44, 52) */
		reached[2][44] = 1;
		(trpt+1)->bup.ovals[35] = ((int)now.light_green[8]);
		now.light_green[8] = 0;
#ifdef VAR_RANGES
		logval("light_green[8]", ((int)now.light_green[8]));
#endif
		;
		/* merge: light_green[9] = 1(52, 45, 52) */
		reached[2][45] = 1;
		(trpt+1)->bup.ovals[36] = ((int)now.light_green[9]);
		now.light_green[9] = 1;
#ifdef VAR_RANGES
		logval("light_green[9]", ((int)now.light_green[9]));
#endif
		;
		/* merge: i = 0(52, 46, 52) */
		reached[2][46] = 1;
		(trpt+1)->bup.ovals[37] = ((int)((P2 *)_this)->i);
		((P2 *)_this)->i = 0;
#ifdef VAR_RANGES
		logval(":init::i", ((int)((P2 *)_this)->i));
#endif
		;
		/* merge: .(goto)(0, 53, 52) */
		reached[2][53] = 1;
		;
		_m = 3; goto P999; /* 39 */
	case 26: // STATE 10 - phase_c_model.pml:829 - [light_enabled[((0*4)+1)] = 1] (0:52:37 - 3)
		IfNotBlocked
		reached[2][10] = 1;
		(trpt+1)->bup.ovals = grab_ints(37);
		(trpt+1)->bup.ovals[0] = ((int)now.light_enabled[ Index(((0*4)+1), 40) ]);
		now.light_enabled[ Index(((0*4)+1), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((0*4)+1)]", ((int)now.light_enabled[ Index(((0*4)+1), 40) ]));
#endif
		;
		/* merge: light_enabled[((0*4)+2)] = 1(52, 11, 52) */
		reached[2][11] = 1;
		(trpt+1)->bup.ovals[1] = ((int)now.light_enabled[ Index(((0*4)+2), 40) ]);
		now.light_enabled[ Index(((0*4)+2), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((0*4)+2)]", ((int)now.light_enabled[ Index(((0*4)+2), 40) ]));
#endif
		;
		/* merge: light_enabled[((0*4)+3)] = 1(52, 12, 52) */
		reached[2][12] = 1;
		(trpt+1)->bup.ovals[2] = ((int)now.light_enabled[ Index(((0*4)+3), 40) ]);
		now.light_enabled[ Index(((0*4)+3), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((0*4)+3)]", ((int)now.light_enabled[ Index(((0*4)+3), 40) ]));
#endif
		;
		/* merge: light_enabled[((1*4)+1)] = 1(52, 13, 52) */
		reached[2][13] = 1;
		(trpt+1)->bup.ovals[3] = ((int)now.light_enabled[ Index(((1*4)+1), 40) ]);
		now.light_enabled[ Index(((1*4)+1), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((1*4)+1)]", ((int)now.light_enabled[ Index(((1*4)+1), 40) ]));
#endif
		;
		/* merge: light_enabled[((1*4)+2)] = 1(52, 14, 52) */
		reached[2][14] = 1;
		(trpt+1)->bup.ovals[4] = ((int)now.light_enabled[ Index(((1*4)+2), 40) ]);
		now.light_enabled[ Index(((1*4)+2), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((1*4)+2)]", ((int)now.light_enabled[ Index(((1*4)+2), 40) ]));
#endif
		;
		/* merge: light_enabled[((1*4)+3)] = 1(52, 15, 52) */
		reached[2][15] = 1;
		(trpt+1)->bup.ovals[5] = ((int)now.light_enabled[ Index(((1*4)+3), 40) ]);
		now.light_enabled[ Index(((1*4)+3), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((1*4)+3)]", ((int)now.light_enabled[ Index(((1*4)+3), 40) ]));
#endif
		;
		/* merge: light_enabled[((2*4)+2)] = 1(52, 16, 52) */
		reached[2][16] = 1;
		(trpt+1)->bup.ovals[6] = ((int)now.light_enabled[ Index(((2*4)+2), 40) ]);
		now.light_enabled[ Index(((2*4)+2), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((2*4)+2)]", ((int)now.light_enabled[ Index(((2*4)+2), 40) ]));
#endif
		;
		/* merge: light_enabled[((2*4)+3)] = 1(52, 17, 52) */
		reached[2][17] = 1;
		(trpt+1)->bup.ovals[7] = ((int)now.light_enabled[ Index(((2*4)+3), 40) ]);
		now.light_enabled[ Index(((2*4)+3), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((2*4)+3)]", ((int)now.light_enabled[ Index(((2*4)+3), 40) ]));
#endif
		;
		/* merge: light_enabled[((3*4)+0)] = 1(52, 18, 52) */
		reached[2][18] = 1;
		(trpt+1)->bup.ovals[8] = ((int)now.light_enabled[ Index(((3*4)+0), 40) ]);
		now.light_enabled[ Index(((3*4)+0), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((3*4)+0)]", ((int)now.light_enabled[ Index(((3*4)+0), 40) ]));
#endif
		;
		/* merge: light_enabled[((3*4)+1)] = 1(52, 19, 52) */
		reached[2][19] = 1;
		(trpt+1)->bup.ovals[9] = ((int)now.light_enabled[ Index(((3*4)+1), 40) ]);
		now.light_enabled[ Index(((3*4)+1), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((3*4)+1)]", ((int)now.light_enabled[ Index(((3*4)+1), 40) ]));
#endif
		;
		/* merge: light_enabled[((3*4)+2)] = 1(52, 20, 52) */
		reached[2][20] = 1;
		(trpt+1)->bup.ovals[10] = ((int)now.light_enabled[ Index(((3*4)+2), 40) ]);
		now.light_enabled[ Index(((3*4)+2), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((3*4)+2)]", ((int)now.light_enabled[ Index(((3*4)+2), 40) ]));
#endif
		;
		/* merge: light_enabled[((4*4)+0)] = 1(52, 21, 52) */
		reached[2][21] = 1;
		(trpt+1)->bup.ovals[11] = ((int)now.light_enabled[ Index(((4*4)+0), 40) ]);
		now.light_enabled[ Index(((4*4)+0), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((4*4)+0)]", ((int)now.light_enabled[ Index(((4*4)+0), 40) ]));
#endif
		;
		/* merge: light_enabled[((4*4)+1)] = 1(52, 22, 52) */
		reached[2][22] = 1;
		(trpt+1)->bup.ovals[12] = ((int)now.light_enabled[ Index(((4*4)+1), 40) ]);
		now.light_enabled[ Index(((4*4)+1), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((4*4)+1)]", ((int)now.light_enabled[ Index(((4*4)+1), 40) ]));
#endif
		;
		/* merge: light_enabled[((4*4)+2)] = 1(52, 23, 52) */
		reached[2][23] = 1;
		(trpt+1)->bup.ovals[13] = ((int)now.light_enabled[ Index(((4*4)+2), 40) ]);
		now.light_enabled[ Index(((4*4)+2), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((4*4)+2)]", ((int)now.light_enabled[ Index(((4*4)+2), 40) ]));
#endif
		;
		/* merge: light_enabled[((4*4)+3)] = 1(52, 24, 52) */
		reached[2][24] = 1;
		(trpt+1)->bup.ovals[14] = ((int)now.light_enabled[ Index(((4*4)+3), 40) ]);
		now.light_enabled[ Index(((4*4)+3), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((4*4)+3)]", ((int)now.light_enabled[ Index(((4*4)+3), 40) ]));
#endif
		;
		/* merge: light_enabled[((5*4)+0)] = 1(52, 25, 52) */
		reached[2][25] = 1;
		(trpt+1)->bup.ovals[15] = ((int)now.light_enabled[ Index(((5*4)+0), 40) ]);
		now.light_enabled[ Index(((5*4)+0), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((5*4)+0)]", ((int)now.light_enabled[ Index(((5*4)+0), 40) ]));
#endif
		;
		/* merge: light_enabled[((5*4)+2)] = 1(52, 26, 52) */
		reached[2][26] = 1;
		(trpt+1)->bup.ovals[16] = ((int)now.light_enabled[ Index(((5*4)+2), 40) ]);
		now.light_enabled[ Index(((5*4)+2), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((5*4)+2)]", ((int)now.light_enabled[ Index(((5*4)+2), 40) ]));
#endif
		;
		/* merge: light_enabled[((5*4)+3)] = 1(52, 27, 52) */
		reached[2][27] = 1;
		(trpt+1)->bup.ovals[17] = ((int)now.light_enabled[ Index(((5*4)+3), 40) ]);
		now.light_enabled[ Index(((5*4)+3), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((5*4)+3)]", ((int)now.light_enabled[ Index(((5*4)+3), 40) ]));
#endif
		;
		/* merge: light_enabled[((6*4)+0)] = 1(52, 28, 52) */
		reached[2][28] = 1;
		(trpt+1)->bup.ovals[18] = ((int)now.light_enabled[ Index(((6*4)+0), 40) ]);
		now.light_enabled[ Index(((6*4)+0), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((6*4)+0)]", ((int)now.light_enabled[ Index(((6*4)+0), 40) ]));
#endif
		;
		/* merge: light_enabled[((6*4)+1)] = 1(52, 29, 52) */
		reached[2][29] = 1;
		(trpt+1)->bup.ovals[19] = ((int)now.light_enabled[ Index(((6*4)+1), 40) ]);
		now.light_enabled[ Index(((6*4)+1), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((6*4)+1)]", ((int)now.light_enabled[ Index(((6*4)+1), 40) ]));
#endif
		;
		/* merge: light_enabled[((7*4)+0)] = 1(52, 30, 52) */
		reached[2][30] = 1;
		(trpt+1)->bup.ovals[20] = ((int)now.light_enabled[ Index(((7*4)+0), 40) ]);
		now.light_enabled[ Index(((7*4)+0), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((7*4)+0)]", ((int)now.light_enabled[ Index(((7*4)+0), 40) ]));
#endif
		;
		/* merge: light_enabled[((7*4)+1)] = 1(52, 31, 52) */
		reached[2][31] = 1;
		(trpt+1)->bup.ovals[21] = ((int)now.light_enabled[ Index(((7*4)+1), 40) ]);
		now.light_enabled[ Index(((7*4)+1), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((7*4)+1)]", ((int)now.light_enabled[ Index(((7*4)+1), 40) ]));
#endif
		;
		/* merge: light_enabled[((7*4)+3)] = 1(52, 32, 52) */
		reached[2][32] = 1;
		(trpt+1)->bup.ovals[22] = ((int)now.light_enabled[ Index(((7*4)+3), 40) ]);
		now.light_enabled[ Index(((7*4)+3), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((7*4)+3)]", ((int)now.light_enabled[ Index(((7*4)+3), 40) ]));
#endif
		;
		/* merge: light_enabled[((8*4)+0)] = 1(52, 33, 52) */
		reached[2][33] = 1;
		(trpt+1)->bup.ovals[23] = ((int)now.light_enabled[ Index(((8*4)+0), 40) ]);
		now.light_enabled[ Index(((8*4)+0), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((8*4)+0)]", ((int)now.light_enabled[ Index(((8*4)+0), 40) ]));
#endif
		;
		/* merge: light_enabled[((8*4)+3)] = 1(52, 34, 52) */
		reached[2][34] = 1;
		(trpt+1)->bup.ovals[24] = ((int)now.light_enabled[ Index(((8*4)+3), 40) ]);
		now.light_enabled[ Index(((8*4)+3), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((8*4)+3)]", ((int)now.light_enabled[ Index(((8*4)+3), 40) ]));
#endif
		;
		/* merge: light_enabled[((9*4)+1)] = 1(52, 35, 52) */
		reached[2][35] = 1;
		(trpt+1)->bup.ovals[25] = ((int)now.light_enabled[ Index(((9*4)+1), 40) ]);
		now.light_enabled[ Index(((9*4)+1), 40) ] = 1;
#ifdef VAR_RANGES
		logval("light_enabled[((9*4)+1)]", ((int)now.light_enabled[ Index(((9*4)+1), 40) ]));
#endif
		;
		/* merge: light_green[0] = 1(52, 36, 52) */
		reached[2][36] = 1;
		(trpt+1)->bup.ovals[26] = ((int)now.light_green[0]);
		now.light_green[0] = 1;
#ifdef VAR_RANGES
		logval("light_green[0]", ((int)now.light_green[0]));
#endif
		;
		/* merge: light_green[1] = 1(52, 37, 52) */
		reached[2][37] = 1;
		(trpt+1)->bup.ovals[27] = ((int)now.light_green[1]);
		now.light_green[1] = 1;
#ifdef VAR_RANGES
		logval("light_green[1]", ((int)now.light_green[1]));
#endif
		;
		/* merge: light_green[2] = 2(52, 38, 52) */
		reached[2][38] = 1;
		(trpt+1)->bup.ovals[28] = ((int)now.light_green[2]);
		now.light_green[2] = 2;
#ifdef VAR_RANGES
		logval("light_green[2]", ((int)now.light_green[2]));
#endif
		;
		/* merge: light_green[3] = 0(52, 39, 52) */
		reached[2][39] = 1;
		(trpt+1)->bup.ovals[29] = ((int)now.light_green[3]);
		now.light_green[3] = 0;
#ifdef VAR_RANGES
		logval("light_green[3]", ((int)now.light_green[3]));
#endif
		;
		/* merge: light_green[4] = 0(52, 40, 52) */
		reached[2][40] = 1;
		(trpt+1)->bup.ovals[30] = ((int)now.light_green[4]);
		now.light_green[4] = 0;
#ifdef VAR_RANGES
		logval("light_green[4]", ((int)now.light_green[4]));
#endif
		;
		/* merge: light_green[5] = 0(52, 41, 52) */
		reached[2][41] = 1;
		(trpt+1)->bup.ovals[31] = ((int)now.light_green[5]);
		now.light_green[5] = 0;
#ifdef VAR_RANGES
		logval("light_green[5]", ((int)now.light_green[5]));
#endif
		;
		/* merge: light_green[6] = 0(52, 42, 52) */
		reached[2][42] = 1;
		(trpt+1)->bup.ovals[32] = ((int)now.light_green[6]);
		now.light_green[6] = 0;
#ifdef VAR_RANGES
		logval("light_green[6]", ((int)now.light_green[6]));
#endif
		;
		/* merge: light_green[7] = 0(52, 43, 52) */
		reached[2][43] = 1;
		(trpt+1)->bup.ovals[33] = ((int)now.light_green[7]);
		now.light_green[7] = 0;
#ifdef VAR_RANGES
		logval("light_green[7]", ((int)now.light_green[7]));
#endif
		;
		/* merge: light_green[8] = 0(52, 44, 52) */
		reached[2][44] = 1;
		(trpt+1)->bup.ovals[34] = ((int)now.light_green[8]);
		now.light_green[8] = 0;
#ifdef VAR_RANGES
		logval("light_green[8]", ((int)now.light_green[8]));
#endif
		;
		/* merge: light_green[9] = 1(52, 45, 52) */
		reached[2][45] = 1;
		(trpt+1)->bup.ovals[35] = ((int)now.light_green[9]);
		now.light_green[9] = 1;
#ifdef VAR_RANGES
		logval("light_green[9]", ((int)now.light_green[9]));
#endif
		;
		/* merge: i = 0(52, 46, 52) */
		reached[2][46] = 1;
		(trpt+1)->bup.ovals[36] = ((int)((P2 *)_this)->i);
		((P2 *)_this)->i = 0;
#ifdef VAR_RANGES
		logval(":init::i", ((int)((P2 *)_this)->i));
#endif
		;
		/* merge: .(goto)(0, 53, 52) */
		reached[2][53] = 1;
		;
		_m = 3; goto P999; /* 37 */
	case 27: // STATE 47 - phase_c_model.pml:889 - [((i<(10*4)))] (52:0:2 - 1)
		IfNotBlocked
		reached[2][47] = 1;
		if (!((((int)((P2 *)_this)->i)<(10*4))))
			continue;
		/* merge: red_streak[i] = 0(52, 48, 52) */
		reached[2][48] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = ((int)now.red_streak[ Index(((int)((P2 *)_this)->i), 40) ]);
		now.red_streak[ Index(((P2 *)_this)->i, 40) ] = 0;
#ifdef VAR_RANGES
		logval("red_streak[:init::i]", ((int)now.red_streak[ Index(((int)((P2 *)_this)->i), 40) ]));
#endif
		;
		/* merge: i = (i+1)(52, 49, 52) */
		reached[2][49] = 1;
		(trpt+1)->bup.ovals[1] = ((int)((P2 *)_this)->i);
		((P2 *)_this)->i = (((int)((P2 *)_this)->i)+1);
#ifdef VAR_RANGES
		logval(":init::i", ((int)((P2 *)_this)->i));
#endif
		;
		/* merge: .(goto)(0, 53, 52) */
		reached[2][53] = 1;
		;
		_m = 3; goto P999; /* 3 */
	case 28: // STATE 50 - phase_c_model.pml:890 - [((i>=(10*4)))] (85:0:30 - 1)
		IfNotBlocked
		reached[2][50] = 1;
		if (!((((int)((P2 *)_this)->i)>=(10*4))))
			continue;
		if (TstOnly) return 1; /* TT */
		/* dead 1: i */  (trpt+1)->bup.ovals = grab_ints(30);
		(trpt+1)->bup.ovals[0] = ((P2 *)_this)->i;
#ifdef HAS_CODE
		if (!readtrail)
#endif
			((P2 *)_this)->i = 0;
		/* merge: goto :b12(85, 51, 85) */
		reached[2][51] = 1;
		;
		/* merge: tour_stops[((0*4)+0)] = 6(85, 55, 85) */
		reached[2][55] = 1;
		(trpt+1)->bup.ovals[1] = ((int)now.tour_stops[ Index(((0*4)+0), 8) ]);
		now.tour_stops[ Index(((0*4)+0), 8) ] = 6;
#ifdef VAR_RANGES
		logval("tour_stops[((0*4)+0)]", ((int)now.tour_stops[ Index(((0*4)+0), 8) ]));
#endif
		;
		/* merge: tour_stops[((0*4)+1)] = 8(85, 56, 85) */
		reached[2][56] = 1;
		(trpt+1)->bup.ovals[2] = ((int)now.tour_stops[ Index(((0*4)+1), 8) ]);
		now.tour_stops[ Index(((0*4)+1), 8) ] = 8;
#ifdef VAR_RANGES
		logval("tour_stops[((0*4)+1)]", ((int)now.tour_stops[ Index(((0*4)+1), 8) ]));
#endif
		;
		/* merge: tour_stops[((0*4)+2)] = 2(85, 57, 85) */
		reached[2][57] = 1;
		(trpt+1)->bup.ovals[3] = ((int)now.tour_stops[ Index(((0*4)+2), 8) ]);
		now.tour_stops[ Index(((0*4)+2), 8) ] = 2;
#ifdef VAR_RANGES
		logval("tour_stops[((0*4)+2)]", ((int)now.tour_stops[ Index(((0*4)+2), 8) ]));
#endif
		;
		/* merge: tour_stops[((0*4)+3)] = 9(85, 58, 85) */
		reached[2][58] = 1;
		(trpt+1)->bup.ovals[4] = ((int)now.tour_stops[ Index(((0*4)+3), 8) ]);
		now.tour_stops[ Index(((0*4)+3), 8) ] = 9;
#ifdef VAR_RANGES
		logval("tour_stops[((0*4)+3)]", ((int)now.tour_stops[ Index(((0*4)+3), 8) ]));
#endif
		;
		/* merge: tour_stops[((1*4)+0)] = 2(85, 59, 85) */
		reached[2][59] = 1;
		(trpt+1)->bup.ovals[5] = ((int)now.tour_stops[ Index(((1*4)+0), 8) ]);
		now.tour_stops[ Index(((1*4)+0), 8) ] = 2;
#ifdef VAR_RANGES
		logval("tour_stops[((1*4)+0)]", ((int)now.tour_stops[ Index(((1*4)+0), 8) ]));
#endif
		;
		/* merge: tour_stops[((1*4)+1)] = 8(85, 60, 85) */
		reached[2][60] = 1;
		(trpt+1)->bup.ovals[6] = ((int)now.tour_stops[ Index(((1*4)+1), 8) ]);
		now.tour_stops[ Index(((1*4)+1), 8) ] = 8;
#ifdef VAR_RANGES
		logval("tour_stops[((1*4)+1)]", ((int)now.tour_stops[ Index(((1*4)+1), 8) ]));
#endif
		;
		/* merge: tour_stops[((1*4)+2)] = 6(85, 61, 85) */
		reached[2][61] = 1;
		(trpt+1)->bup.ovals[7] = ((int)now.tour_stops[ Index(((1*4)+2), 8) ]);
		now.tour_stops[ Index(((1*4)+2), 8) ] = 6;
#ifdef VAR_RANGES
		logval("tour_stops[((1*4)+2)]", ((int)now.tour_stops[ Index(((1*4)+2), 8) ]));
#endif
		;
		/* merge: tour_stops[((1*4)+3)] = 9(85, 62, 85) */
		reached[2][62] = 1;
		(trpt+1)->bup.ovals[8] = ((int)now.tour_stops[ Index(((1*4)+3), 8) ]);
		now.tour_stops[ Index(((1*4)+3), 8) ] = 9;
#ifdef VAR_RANGES
		logval("tour_stops[((1*4)+3)]", ((int)now.tour_stops[ Index(((1*4)+3), 8) ]));
#endif
		;
		/* merge: veh_mode[0] = 0(85, 63, 85) */
		reached[2][63] = 1;
		(trpt+1)->bup.ovals[9] = ((int)now.veh_mode[0]);
		now.veh_mode[0] = 0;
#ifdef VAR_RANGES
		logval("veh_mode[0]", ((int)now.veh_mode[0]));
#endif
		;
		/* merge: veh_node[0] = 9(85, 64, 85) */
		reached[2][64] = 1;
		(trpt+1)->bup.ovals[10] = ((int)now.veh_node[0]);
		now.veh_node[0] = 9;
#ifdef VAR_RANGES
		logval("veh_node[0]", ((int)now.veh_node[0]));
#endif
		;
		/* merge: veh_heading[0] = 255(85, 65, 85) */
		reached[2][65] = 1;
		(trpt+1)->bup.ovals[11] = ((int)now.veh_heading[0]);
		now.veh_heading[0] = 255;
#ifdef VAR_RANGES
		logval("veh_heading[0]", ((int)now.veh_heading[0]));
#endif
		;
		/* merge: veh_dest[0] = 6(85, 66, 85) */
		reached[2][66] = 1;
		(trpt+1)->bup.ovals[12] = ((int)now.veh_dest[0]);
		now.veh_dest[0] = 6;
#ifdef VAR_RANGES
		logval("veh_dest[0]", ((int)now.veh_dest[0]));
#endif
		;
		/* merge: veh_dest_idx[0] = 0(85, 67, 85) */
		reached[2][67] = 1;
		(trpt+1)->bup.ovals[13] = ((int)now.veh_dest_idx[0]);
		now.veh_dest_idx[0] = 0;
#ifdef VAR_RANGES
		logval("veh_dest_idx[0]", ((int)now.veh_dest_idx[0]));
#endif
		;
		/* merge: visited_B[0] = 0(85, 68, 85) */
		reached[2][68] = 1;
		(trpt+1)->bup.ovals[14] = ((int)now.visited_B[0]);
		now.visited_B[0] = 0;
#ifdef VAR_RANGES
		logval("visited_B[0]", ((int)now.visited_B[0]));
#endif
		;
		/* merge: visited_C[0] = 0(85, 69, 85) */
		reached[2][69] = 1;
		(trpt+1)->bup.ovals[15] = ((int)now.visited_C[0]);
		now.visited_C[0] = 0;
#ifdef VAR_RANGES
		logval("visited_C[0]", ((int)now.visited_C[0]));
#endif
		;
		/* merge: visited_D[0] = 0(85, 70, 85) */
		reached[2][70] = 1;
		(trpt+1)->bup.ovals[16] = ((int)now.visited_D[0]);
		now.visited_D[0] = 0;
#ifdef VAR_RANGES
		logval("visited_D[0]", ((int)now.visited_D[0]));
#endif
		;
		/* merge: returned_A[0] = 0(85, 71, 85) */
		reached[2][71] = 1;
		(trpt+1)->bup.ovals[17] = ((int)now.returned_A[0]);
		now.returned_A[0] = 0;
#ifdef VAR_RANGES
		logval("returned_A[0]", ((int)now.returned_A[0]));
#endif
		;
		/* merge: sq_a_forbidden[0] = 255(85, 72, 85) */
		reached[2][72] = 1;
		(trpt+1)->bup.ovals[18] = ((int)now.sq_a_forbidden[0]);
		now.sq_a_forbidden[0] = 255;
#ifdef VAR_RANGES
		logval("sq_a_forbidden[0]", ((int)now.sq_a_forbidden[0]));
#endif
		;
		/* merge: veh_mode[1] = 0(85, 73, 85) */
		reached[2][73] = 1;
		(trpt+1)->bup.ovals[19] = ((int)now.veh_mode[1]);
		now.veh_mode[1] = 0;
#ifdef VAR_RANGES
		logval("veh_mode[1]", ((int)now.veh_mode[1]));
#endif
		;
		/* merge: veh_node[1] = 9(85, 74, 85) */
		reached[2][74] = 1;
		(trpt+1)->bup.ovals[20] = ((int)now.veh_node[1]);
		now.veh_node[1] = 9;
#ifdef VAR_RANGES
		logval("veh_node[1]", ((int)now.veh_node[1]));
#endif
		;
		/* merge: veh_heading[1] = 255(85, 75, 85) */
		reached[2][75] = 1;
		(trpt+1)->bup.ovals[21] = ((int)now.veh_heading[1]);
		now.veh_heading[1] = 255;
#ifdef VAR_RANGES
		logval("veh_heading[1]", ((int)now.veh_heading[1]));
#endif
		;
		/* merge: veh_dest[1] = 2(85, 76, 85) */
		reached[2][76] = 1;
		(trpt+1)->bup.ovals[22] = ((int)now.veh_dest[1]);
		now.veh_dest[1] = 2;
#ifdef VAR_RANGES
		logval("veh_dest[1]", ((int)now.veh_dest[1]));
#endif
		;
		/* merge: veh_dest_idx[1] = 0(85, 77, 85) */
		reached[2][77] = 1;
		(trpt+1)->bup.ovals[23] = ((int)now.veh_dest_idx[1]);
		now.veh_dest_idx[1] = 0;
#ifdef VAR_RANGES
		logval("veh_dest_idx[1]", ((int)now.veh_dest_idx[1]));
#endif
		;
		/* merge: visited_B[1] = 0(85, 78, 85) */
		reached[2][78] = 1;
		(trpt+1)->bup.ovals[24] = ((int)now.visited_B[1]);
		now.visited_B[1] = 0;
#ifdef VAR_RANGES
		logval("visited_B[1]", ((int)now.visited_B[1]));
#endif
		;
		/* merge: visited_C[1] = 0(85, 79, 85) */
		reached[2][79] = 1;
		(trpt+1)->bup.ovals[25] = ((int)now.visited_C[1]);
		now.visited_C[1] = 0;
#ifdef VAR_RANGES
		logval("visited_C[1]", ((int)now.visited_C[1]));
#endif
		;
		/* merge: visited_D[1] = 0(85, 80, 85) */
		reached[2][80] = 1;
		(trpt+1)->bup.ovals[26] = ((int)now.visited_D[1]);
		now.visited_D[1] = 0;
#ifdef VAR_RANGES
		logval("visited_D[1]", ((int)now.visited_D[1]));
#endif
		;
		/* merge: returned_A[1] = 0(85, 81, 85) */
		reached[2][81] = 1;
		(trpt+1)->bup.ovals[27] = ((int)now.returned_A[1]);
		now.returned_A[1] = 0;
#ifdef VAR_RANGES
		logval("returned_A[1]", ((int)now.returned_A[1]));
#endif
		;
		/* merge: sq_a_forbidden[1] = 255(85, 82, 85) */
		reached[2][82] = 1;
		(trpt+1)->bup.ovals[28] = ((int)now.sq_a_forbidden[1]);
		now.sq_a_forbidden[1] = 255;
#ifdef VAR_RANGES
		logval("sq_a_forbidden[1]", ((int)now.sq_a_forbidden[1]));
#endif
		;
		/* merge: model_initialized = 1(85, 83, 85) */
		reached[2][83] = 1;
		(trpt+1)->bup.ovals[29] = ((int)now.model_initialized);
		now.model_initialized = 1;
#ifdef VAR_RANGES
		logval("model_initialized", ((int)now.model_initialized));
#endif
		;
		_m = 3; goto P999; /* 30 */
	case 29: // STATE 55 - phase_c_model.pml:898 - [tour_stops[((0*4)+0)] = 6] (0:85:29 - 3)
		IfNotBlocked
		reached[2][55] = 1;
		(trpt+1)->bup.ovals = grab_ints(29);
		(trpt+1)->bup.ovals[0] = ((int)now.tour_stops[ Index(((0*4)+0), 8) ]);
		now.tour_stops[ Index(((0*4)+0), 8) ] = 6;
#ifdef VAR_RANGES
		logval("tour_stops[((0*4)+0)]", ((int)now.tour_stops[ Index(((0*4)+0), 8) ]));
#endif
		;
		/* merge: tour_stops[((0*4)+1)] = 8(85, 56, 85) */
		reached[2][56] = 1;
		(trpt+1)->bup.ovals[1] = ((int)now.tour_stops[ Index(((0*4)+1), 8) ]);
		now.tour_stops[ Index(((0*4)+1), 8) ] = 8;
#ifdef VAR_RANGES
		logval("tour_stops[((0*4)+1)]", ((int)now.tour_stops[ Index(((0*4)+1), 8) ]));
#endif
		;
		/* merge: tour_stops[((0*4)+2)] = 2(85, 57, 85) */
		reached[2][57] = 1;
		(trpt+1)->bup.ovals[2] = ((int)now.tour_stops[ Index(((0*4)+2), 8) ]);
		now.tour_stops[ Index(((0*4)+2), 8) ] = 2;
#ifdef VAR_RANGES
		logval("tour_stops[((0*4)+2)]", ((int)now.tour_stops[ Index(((0*4)+2), 8) ]));
#endif
		;
		/* merge: tour_stops[((0*4)+3)] = 9(85, 58, 85) */
		reached[2][58] = 1;
		(trpt+1)->bup.ovals[3] = ((int)now.tour_stops[ Index(((0*4)+3), 8) ]);
		now.tour_stops[ Index(((0*4)+3), 8) ] = 9;
#ifdef VAR_RANGES
		logval("tour_stops[((0*4)+3)]", ((int)now.tour_stops[ Index(((0*4)+3), 8) ]));
#endif
		;
		/* merge: tour_stops[((1*4)+0)] = 2(85, 59, 85) */
		reached[2][59] = 1;
		(trpt+1)->bup.ovals[4] = ((int)now.tour_stops[ Index(((1*4)+0), 8) ]);
		now.tour_stops[ Index(((1*4)+0), 8) ] = 2;
#ifdef VAR_RANGES
		logval("tour_stops[((1*4)+0)]", ((int)now.tour_stops[ Index(((1*4)+0), 8) ]));
#endif
		;
		/* merge: tour_stops[((1*4)+1)] = 8(85, 60, 85) */
		reached[2][60] = 1;
		(trpt+1)->bup.ovals[5] = ((int)now.tour_stops[ Index(((1*4)+1), 8) ]);
		now.tour_stops[ Index(((1*4)+1), 8) ] = 8;
#ifdef VAR_RANGES
		logval("tour_stops[((1*4)+1)]", ((int)now.tour_stops[ Index(((1*4)+1), 8) ]));
#endif
		;
		/* merge: tour_stops[((1*4)+2)] = 6(85, 61, 85) */
		reached[2][61] = 1;
		(trpt+1)->bup.ovals[6] = ((int)now.tour_stops[ Index(((1*4)+2), 8) ]);
		now.tour_stops[ Index(((1*4)+2), 8) ] = 6;
#ifdef VAR_RANGES
		logval("tour_stops[((1*4)+2)]", ((int)now.tour_stops[ Index(((1*4)+2), 8) ]));
#endif
		;
		/* merge: tour_stops[((1*4)+3)] = 9(85, 62, 85) */
		reached[2][62] = 1;
		(trpt+1)->bup.ovals[7] = ((int)now.tour_stops[ Index(((1*4)+3), 8) ]);
		now.tour_stops[ Index(((1*4)+3), 8) ] = 9;
#ifdef VAR_RANGES
		logval("tour_stops[((1*4)+3)]", ((int)now.tour_stops[ Index(((1*4)+3), 8) ]));
#endif
		;
		/* merge: veh_mode[0] = 0(85, 63, 85) */
		reached[2][63] = 1;
		(trpt+1)->bup.ovals[8] = ((int)now.veh_mode[0]);
		now.veh_mode[0] = 0;
#ifdef VAR_RANGES
		logval("veh_mode[0]", ((int)now.veh_mode[0]));
#endif
		;
		/* merge: veh_node[0] = 9(85, 64, 85) */
		reached[2][64] = 1;
		(trpt+1)->bup.ovals[9] = ((int)now.veh_node[0]);
		now.veh_node[0] = 9;
#ifdef VAR_RANGES
		logval("veh_node[0]", ((int)now.veh_node[0]));
#endif
		;
		/* merge: veh_heading[0] = 255(85, 65, 85) */
		reached[2][65] = 1;
		(trpt+1)->bup.ovals[10] = ((int)now.veh_heading[0]);
		now.veh_heading[0] = 255;
#ifdef VAR_RANGES
		logval("veh_heading[0]", ((int)now.veh_heading[0]));
#endif
		;
		/* merge: veh_dest[0] = 6(85, 66, 85) */
		reached[2][66] = 1;
		(trpt+1)->bup.ovals[11] = ((int)now.veh_dest[0]);
		now.veh_dest[0] = 6;
#ifdef VAR_RANGES
		logval("veh_dest[0]", ((int)now.veh_dest[0]));
#endif
		;
		/* merge: veh_dest_idx[0] = 0(85, 67, 85) */
		reached[2][67] = 1;
		(trpt+1)->bup.ovals[12] = ((int)now.veh_dest_idx[0]);
		now.veh_dest_idx[0] = 0;
#ifdef VAR_RANGES
		logval("veh_dest_idx[0]", ((int)now.veh_dest_idx[0]));
#endif
		;
		/* merge: visited_B[0] = 0(85, 68, 85) */
		reached[2][68] = 1;
		(trpt+1)->bup.ovals[13] = ((int)now.visited_B[0]);
		now.visited_B[0] = 0;
#ifdef VAR_RANGES
		logval("visited_B[0]", ((int)now.visited_B[0]));
#endif
		;
		/* merge: visited_C[0] = 0(85, 69, 85) */
		reached[2][69] = 1;
		(trpt+1)->bup.ovals[14] = ((int)now.visited_C[0]);
		now.visited_C[0] = 0;
#ifdef VAR_RANGES
		logval("visited_C[0]", ((int)now.visited_C[0]));
#endif
		;
		/* merge: visited_D[0] = 0(85, 70, 85) */
		reached[2][70] = 1;
		(trpt+1)->bup.ovals[15] = ((int)now.visited_D[0]);
		now.visited_D[0] = 0;
#ifdef VAR_RANGES
		logval("visited_D[0]", ((int)now.visited_D[0]));
#endif
		;
		/* merge: returned_A[0] = 0(85, 71, 85) */
		reached[2][71] = 1;
		(trpt+1)->bup.ovals[16] = ((int)now.returned_A[0]);
		now.returned_A[0] = 0;
#ifdef VAR_RANGES
		logval("returned_A[0]", ((int)now.returned_A[0]));
#endif
		;
		/* merge: sq_a_forbidden[0] = 255(85, 72, 85) */
		reached[2][72] = 1;
		(trpt+1)->bup.ovals[17] = ((int)now.sq_a_forbidden[0]);
		now.sq_a_forbidden[0] = 255;
#ifdef VAR_RANGES
		logval("sq_a_forbidden[0]", ((int)now.sq_a_forbidden[0]));
#endif
		;
		/* merge: veh_mode[1] = 0(85, 73, 85) */
		reached[2][73] = 1;
		(trpt+1)->bup.ovals[18] = ((int)now.veh_mode[1]);
		now.veh_mode[1] = 0;
#ifdef VAR_RANGES
		logval("veh_mode[1]", ((int)now.veh_mode[1]));
#endif
		;
		/* merge: veh_node[1] = 9(85, 74, 85) */
		reached[2][74] = 1;
		(trpt+1)->bup.ovals[19] = ((int)now.veh_node[1]);
		now.veh_node[1] = 9;
#ifdef VAR_RANGES
		logval("veh_node[1]", ((int)now.veh_node[1]));
#endif
		;
		/* merge: veh_heading[1] = 255(85, 75, 85) */
		reached[2][75] = 1;
		(trpt+1)->bup.ovals[20] = ((int)now.veh_heading[1]);
		now.veh_heading[1] = 255;
#ifdef VAR_RANGES
		logval("veh_heading[1]", ((int)now.veh_heading[1]));
#endif
		;
		/* merge: veh_dest[1] = 2(85, 76, 85) */
		reached[2][76] = 1;
		(trpt+1)->bup.ovals[21] = ((int)now.veh_dest[1]);
		now.veh_dest[1] = 2;
#ifdef VAR_RANGES
		logval("veh_dest[1]", ((int)now.veh_dest[1]));
#endif
		;
		/* merge: veh_dest_idx[1] = 0(85, 77, 85) */
		reached[2][77] = 1;
		(trpt+1)->bup.ovals[22] = ((int)now.veh_dest_idx[1]);
		now.veh_dest_idx[1] = 0;
#ifdef VAR_RANGES
		logval("veh_dest_idx[1]", ((int)now.veh_dest_idx[1]));
#endif
		;
		/* merge: visited_B[1] = 0(85, 78, 85) */
		reached[2][78] = 1;
		(trpt+1)->bup.ovals[23] = ((int)now.visited_B[1]);
		now.visited_B[1] = 0;
#ifdef VAR_RANGES
		logval("visited_B[1]", ((int)now.visited_B[1]));
#endif
		;
		/* merge: visited_C[1] = 0(85, 79, 85) */
		reached[2][79] = 1;
		(trpt+1)->bup.ovals[24] = ((int)now.visited_C[1]);
		now.visited_C[1] = 0;
#ifdef VAR_RANGES
		logval("visited_C[1]", ((int)now.visited_C[1]));
#endif
		;
		/* merge: visited_D[1] = 0(85, 80, 85) */
		reached[2][80] = 1;
		(trpt+1)->bup.ovals[25] = ((int)now.visited_D[1]);
		now.visited_D[1] = 0;
#ifdef VAR_RANGES
		logval("visited_D[1]", ((int)now.visited_D[1]));
#endif
		;
		/* merge: returned_A[1] = 0(85, 81, 85) */
		reached[2][81] = 1;
		(trpt+1)->bup.ovals[26] = ((int)now.returned_A[1]);
		now.returned_A[1] = 0;
#ifdef VAR_RANGES
		logval("returned_A[1]", ((int)now.returned_A[1]));
#endif
		;
		/* merge: sq_a_forbidden[1] = 255(85, 82, 85) */
		reached[2][82] = 1;
		(trpt+1)->bup.ovals[27] = ((int)now.sq_a_forbidden[1]);
		now.sq_a_forbidden[1] = 255;
#ifdef VAR_RANGES
		logval("sq_a_forbidden[1]", ((int)now.sq_a_forbidden[1]));
#endif
		;
		/* merge: model_initialized = 1(85, 83, 85) */
		reached[2][83] = 1;
		(trpt+1)->bup.ovals[28] = ((int)now.model_initialized);
		now.model_initialized = 1;
#ifdef VAR_RANGES
		logval("model_initialized", ((int)now.model_initialized));
#endif
		;
		_m = 3; goto P999; /* 28 */
	case 30: // STATE 85 - phase_c_model.pml:935 - [(run InfraFSM())] (0:0:0 - 1)
		IfNotBlocked
		reached[2][85] = 1;
		if (!(addproc(II, 1, 0, 0)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 31: // STATE 86 - phase_c_model.pml:936 - [(run VehicleFSM(0))] (0:0:0 - 1)
		IfNotBlocked
		reached[2][86] = 1;
		if (!(addproc(II, 1, 1, 0)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 32: // STATE 87 - phase_c_model.pml:937 - [(run VehicleFSM(1))] (0:0:0 - 1)
		IfNotBlocked
		reached[2][87] = 1;
		if (!(addproc(II, 1, 1, 1)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 33: // STATE 88 - phase_c_model.pml:941 - [((returned_A[0]&&returned_A[1]))] (0:0:0 - 1)
		IfNotBlocked
		reached[2][88] = 1;
		if (!((((int)now.returned_A[0])&&((int)now.returned_A[1]))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 34: // STATE 89 - phase_c_model.pml:942 - [all_tours_done = 1] (0:0:1 - 1)
		IfNotBlocked
		reached[2][89] = 1;
		(trpt+1)->bup.oval = ((int)all_tours_done);
		all_tours_done = 1;
#ifdef VAR_RANGES
		logval("all_tours_done", ((int)all_tours_done));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 35: // STATE 91 - phase_c_model.pml:945 - [((tick_count>=120))] (0:0:1 - 1)
		IfNotBlocked
		reached[2][91] = 1;
		if (!((((int)((P2 *)_this)->tick_count)>=120)))
			continue;
		if (TstOnly) return 1; /* TT */
		/* dead 1: tick_count */  (trpt+1)->bup.oval = ((P2 *)_this)->tick_count;
#ifdef HAS_CODE
		if (!readtrail)
#endif
			((P2 *)_this)->tick_count = 0;
		_m = 3; goto P999; /* 0 */
	case 36: // STATE 106 - phase_c_model.pml:949 - [D_STEP949]
		IfNotBlocked

		reached[2][106] = 1;
		reached[2][t->st] = 1;
		reached[2][tt] = 1;

		if (TstOnly) return 1;

		sv_save();
		S_692_0: /* 2 */
		((P2 *)_this)->i = 0;
#ifdef VAR_RANGES
		logval(":init::i", ((int)((P2 *)_this)->i));
#endif
		;
S_700_0: /* 2 */
S_699_0: /* 2 */
S_693_0: /* 2 */
		if (!((((int)((P2 *)_this)->i)<10)))
			goto S_699_1;
S_694_0: /* 2 */
		now.node_occupied[ Index(((P2 *)_this)->i, 10) ] = 0;
#ifdef VAR_RANGES
		logval("node_occupied[:init::i]", ((int)now.node_occupied[ Index(((int)((P2 *)_this)->i), 10) ]));
#endif
		;
S_695_0: /* 2 */
		now.crossing_count[ Index(((P2 *)_this)->i, 10) ] = 0;
#ifdef VAR_RANGES
		logval("crossing_count[:init::i]", ((int)now.crossing_count[ Index(((int)((P2 *)_this)->i), 10) ]));
#endif
		;
S_696_0: /* 2 */
		((P2 *)_this)->i = (((int)((P2 *)_this)->i)+1);
#ifdef VAR_RANGES
		logval(":init::i", ((int)((P2 *)_this)->i));
#endif
		;
		goto S_700_0; /* ';' */
S_699_1: /* 3 */
S_697_0: /* 2 */
		if (!((((int)((P2 *)_this)->i)>=10)))
			goto S_699_2;
S_698_0: /* 2 */
		goto S_702_0;	/* 'goto' */
S_699_2: /* 3 */
		Uerror("blocking sel in d_step (nr.0, near line 951)");
S_701_0: /* 2 */
		goto S_702_0;	/* 'break' */
S_702_0: /* 2 */
		now.moved_this_step[0] = 0;
#ifdef VAR_RANGES
		logval("moved_this_step[0]", ((int)now.moved_this_step[0]));
#endif
		;
S_703_0: /* 2 */
		now.moved_this_step[1] = 0;
#ifdef VAR_RANGES
		logval("moved_this_step[1]", ((int)now.moved_this_step[1]));
#endif
		;
		goto S_705_0;
S_705_0: /* 1 */

#if defined(C_States) && (HAS_TRACK==1)
		c_update((uchar *) &(now.c_state[0]));
#endif
		_m = 3; goto P999;

	case 37: // STATE 107 - phase_c_model.pml:963 - [tick_infra!0] (0:0:0 - 1)
		IfNotBlocked
		reached[2][107] = 1;
		if (q_len(now.tick_infra))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", now.tick_infra);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		
		qsend(now.tick_infra, 0, 0, 1);
		{ boq = now.tick_infra; };
		_m = 2; goto P999; /* 0 */
	case 38: // STATE 108 - phase_c_model.pml:964 - [done_infra?dummy] (0:0:2 - 1)
		reached[2][108] = 1;
		if (boq != now.done_infra) continue;
		if (q_len(now.done_infra) == 0) continue;

		XX=1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = ((int)((P2 *)_this)->dummy);
		;
		((P2 *)_this)->dummy = qrecv(now.done_infra, XX-1, 0, 1);
#ifdef VAR_RANGES
		logval(":init::dummy", ((int)((P2 *)_this)->dummy));
#endif
		;
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", now.done_infra);
			sprintf(simtmp, "%d", ((int)((P2 *)_this)->dummy)); strcat(simvals, simtmp);
		}
#endif
		if (q_zero(now.done_infra))
		{	boq = -1;
#ifndef NOFAIR
			if (fairness
			&& !(trpt->o_pm&32)
			&& (now._a_t&2)
			&&  now._cnt[now._a_t&1] == II+2)
			{	now._cnt[now._a_t&1] -= 1;
#ifdef VERI
				if (II == 1)
					now._cnt[now._a_t&1] = 1;
#endif
#ifdef DEBUG
			printf("%3ld: proc %d fairness ", depth, II);
			printf("Rule 2: --cnt to %d (%d)\n",
				now._cnt[now._a_t&1], now._a_t);
#endif
				trpt->o_pm |= (32|64);
			}
#endif

		};
		if (TstOnly) return 1; /* TT */
		/* dead 2: dummy */  (trpt+1)->bup.ovals[1] = ((P2 *)_this)->dummy;
#ifdef HAS_CODE
		if (!readtrail)
#endif
			((P2 *)_this)->dummy = 0;
		_m = 4; goto P999; /* 0 */
	case 39: // STATE 109 - phase_c_model.pml:967 - [tick_vehicle[0]!0] (0:0:0 - 1)
		IfNotBlocked
		reached[2][109] = 1;
		if (q_len(now.tick_vehicle[0]))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", now.tick_vehicle[0]);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		
		qsend(now.tick_vehicle[0], 0, 0, 1);
		{ boq = now.tick_vehicle[0]; };
		_m = 2; goto P999; /* 0 */
	case 40: // STATE 110 - phase_c_model.pml:968 - [tick_vehicle[1]!0] (0:0:0 - 1)
		IfNotBlocked
		reached[2][110] = 1;
		if (q_len(now.tick_vehicle[1]))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", now.tick_vehicle[1]);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		
		qsend(now.tick_vehicle[1], 0, 0, 1);
		{ boq = now.tick_vehicle[1]; };
		_m = 2; goto P999; /* 0 */
	case 41: // STATE 111 - phase_c_model.pml:969 - [done_vehicle[0]?dummy] (0:0:2 - 1)
		reached[2][111] = 1;
		if (boq != now.done_vehicle[0]) continue;
		if (q_len(now.done_vehicle[0]) == 0) continue;

		XX=1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = ((int)((P2 *)_this)->dummy);
		;
		((P2 *)_this)->dummy = qrecv(now.done_vehicle[0], XX-1, 0, 1);
#ifdef VAR_RANGES
		logval(":init::dummy", ((int)((P2 *)_this)->dummy));
#endif
		;
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", now.done_vehicle[0]);
			sprintf(simtmp, "%d", ((int)((P2 *)_this)->dummy)); strcat(simvals, simtmp);
		}
#endif
		if (q_zero(now.done_vehicle[0]))
		{	boq = -1;
#ifndef NOFAIR
			if (fairness
			&& !(trpt->o_pm&32)
			&& (now._a_t&2)
			&&  now._cnt[now._a_t&1] == II+2)
			{	now._cnt[now._a_t&1] -= 1;
#ifdef VERI
				if (II == 1)
					now._cnt[now._a_t&1] = 1;
#endif
#ifdef DEBUG
			printf("%3ld: proc %d fairness ", depth, II);
			printf("Rule 2: --cnt to %d (%d)\n",
				now._cnt[now._a_t&1], now._a_t);
#endif
				trpt->o_pm |= (32|64);
			}
#endif

		};
		if (TstOnly) return 1; /* TT */
		/* dead 2: dummy */  (trpt+1)->bup.ovals[1] = ((P2 *)_this)->dummy;
#ifdef HAS_CODE
		if (!readtrail)
#endif
			((P2 *)_this)->dummy = 0;
		_m = 4; goto P999; /* 0 */
	case 42: // STATE 112 - phase_c_model.pml:970 - [done_vehicle[1]?dummy] (0:0:2 - 1)
		reached[2][112] = 1;
		if (boq != now.done_vehicle[1]) continue;
		if (q_len(now.done_vehicle[1]) == 0) continue;

		XX=1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = ((int)((P2 *)_this)->dummy);
		;
		((P2 *)_this)->dummy = qrecv(now.done_vehicle[1], XX-1, 0, 1);
#ifdef VAR_RANGES
		logval(":init::dummy", ((int)((P2 *)_this)->dummy));
#endif
		;
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", now.done_vehicle[1]);
			sprintf(simtmp, "%d", ((int)((P2 *)_this)->dummy)); strcat(simvals, simtmp);
		}
#endif
		if (q_zero(now.done_vehicle[1]))
		{	boq = -1;
#ifndef NOFAIR
			if (fairness
			&& !(trpt->o_pm&32)
			&& (now._a_t&2)
			&&  now._cnt[now._a_t&1] == II+2)
			{	now._cnt[now._a_t&1] -= 1;
#ifdef VERI
				if (II == 1)
					now._cnt[now._a_t&1] = 1;
#endif
#ifdef DEBUG
			printf("%3ld: proc %d fairness ", depth, II);
			printf("Rule 2: --cnt to %d (%d)\n",
				now._cnt[now._a_t&1], now._a_t);
#endif
				trpt->o_pm |= (32|64);
			}
#endif

		};
		if (TstOnly) return 1; /* TT */
		/* dead 2: dummy */  (trpt+1)->bup.ovals[1] = ((P2 *)_this)->dummy;
#ifdef HAS_CODE
		if (!readtrail)
#endif
			((P2 *)_this)->dummy = 0;
		_m = 4; goto P999; /* 0 */
	case 43: // STATE 338 - phase_c_model.pml:973 - [D_STEP973]
		if (!(((boq == -1 && (((((((int)now.veh_mode[0])==1)&&(((int)now.veh_mode[1])==1))&&(((int)now.veh_road[0])==((int)now.veh_road[1])))&&(((int)now.veh_dir[0])==((int)now.veh_dir[1])))&&(((int)now.veh_slot[0])==((int)now.veh_slot[1]))))) || (boq == -1 /* else */)))
			continue;

		reached[2][338] = 1;
		reached[2][t->st] = 1;
		reached[2][tt] = 1;

		if (TstOnly) return 1;


		reached[2][338] = 1;
		reached[2][t->st] = 1;
		reached[2][tt] = 1;

		sv_save();
		S_935_0: /* 2 */
S_715_0: /* 2 */
S_711_0: /* 2 */
		if (!((((((((int)now.veh_mode[0])==1)&&(((int)now.veh_mode[1])==1))&&(((int)now.veh_road[0])==((int)now.veh_road[1])))&&(((int)now.veh_dir[0])==((int)now.veh_dir[1])))&&(((int)now.veh_slot[0])==((int)now.veh_slot[1])))))
			goto S_715_1;
S_712_0: /* 2 */
		now.collision = 1;
#ifdef VAR_RANGES
		logval("collision", ((int)now.collision));
#endif
		;
		goto S_716_0;
S_715_1: /* 3 */
S_713_0: /* 2 */
		/* else */;
S_714_0: /* 2 */
		if (!(1))
			Uerror("block in d_step seq");
		goto S_716_0;
S_715_2: /* 3 */
		Uerror("blocking sel in d_step (nr.1, near line 419)");
S_716_0: /* 2 */
S_723_0: /* 2 */
S_717_0: /* 2 */
		if (!(((((int)now.veh_mode[0])==1)&&(((int)now.road_slots[ Index((((((int)now.veh_road[0])*(2*3))+(((int)now.veh_dir[0])*3))+((int)now.veh_slot[0])), 78) ])!=1))))
			goto S_723_1;
S_718_0: /* 2 */
		now.collision = 1;
#ifdef VAR_RANGES
		logval("collision", ((int)now.collision));
#endif
		;
		goto S_724_0;
S_723_1: /* 3 */
S_719_0: /* 2 */
		if (!(((((int)now.veh_mode[0])==1)&&(((int)now.road_slots[ Index((((((int)now.veh_road[0])*(2*3))+(((int)now.veh_dir[0])*3))+((int)now.veh_slot[0])), 78) ])==1))))
			goto S_723_2;
S_720_0: /* 2 */
		if (!(1))
			Uerror("block in d_step seq");
		goto S_724_0;
S_723_2: /* 3 */
S_721_0: /* 2 */
		if (!((((int)now.veh_mode[0])==0)))
			goto S_723_3;
S_722_0: /* 2 */
		if (!(1))
			Uerror("block in d_step seq");
		goto S_724_0;
S_723_3: /* 3 */
		Uerror("blocking sel in d_step (nr.2, near line 428)");
S_724_0: /* 2 */
S_731_0: /* 2 */
S_725_0: /* 2 */
		if (!(((((int)now.veh_mode[1])==1)&&(((int)now.road_slots[ Index((((((int)now.veh_road[1])*(2*3))+(((int)now.veh_dir[1])*3))+((int)now.veh_slot[1])), 78) ])!=2))))
			goto S_731_1;
S_726_0: /* 2 */
		now.collision = 1;
#ifdef VAR_RANGES
		logval("collision", ((int)now.collision));
#endif
		;
		goto S_732_0;
S_731_1: /* 3 */
S_727_0: /* 2 */
		if (!(((((int)now.veh_mode[1])==1)&&(((int)now.road_slots[ Index((((((int)now.veh_road[1])*(2*3))+(((int)now.veh_dir[1])*3))+((int)now.veh_slot[1])), 78) ])==2))))
			goto S_731_2;
S_728_0: /* 2 */
		if (!(1))
			Uerror("block in d_step seq");
		goto S_732_0;
S_731_2: /* 3 */
S_729_0: /* 2 */
		if (!((((int)now.veh_mode[1])==0)))
			goto S_731_3;
S_730_0: /* 2 */
		if (!(1))
			Uerror("block in d_step seq");
		goto S_732_0;
S_731_3: /* 3 */
		Uerror("blocking sel in d_step (nr.3, near line 434)");
S_732_0: /* 2 */
S_826_0: /* 2 */
S_733_0: /* 2 */
		if (!((((((int)now.veh_mode[0])==1)&&(((int)now.veh_slot[0])==0))&&((int)now.moved_this_step[0]))))
			goto S_826_1;
S_734_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n0 = 255;
#ifdef VAR_RANGES
		logval(":init::src_n0", ((int)((P2 *)_this)->_8_5_1_src_n0));
#endif
		;
S_735_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d0 = 255;
#ifdef VAR_RANGES
		logval(":init::src_d0", ((int)((P2 *)_this)->_8_5_1_src_d0));
#endif
		;
S_816_0: /* 2 */
S_736_0: /* 2 */
		if (!(((((int)now.veh_road[0])==0)&&(((int)now.veh_dir[0])==0))))
			goto S_816_1;
S_737_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n0 = 0;
#ifdef VAR_RANGES
		logval(":init::src_n0", ((int)((P2 *)_this)->_8_5_1_src_n0));
#endif
		;
S_738_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d0 = 1;
#ifdef VAR_RANGES
		logval(":init::src_d0", ((int)((P2 *)_this)->_8_5_1_src_d0));
#endif
		;
		goto S_817_0;
S_816_1: /* 3 */
S_739_0: /* 2 */
		if (!(((((int)now.veh_road[0])==0)&&(((int)now.veh_dir[0])==1))))
			goto S_816_2;
S_740_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n0 = 1;
#ifdef VAR_RANGES
		logval(":init::src_n0", ((int)((P2 *)_this)->_8_5_1_src_n0));
#endif
		;
S_741_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d0 = 3;
#ifdef VAR_RANGES
		logval(":init::src_d0", ((int)((P2 *)_this)->_8_5_1_src_d0));
#endif
		;
		goto S_817_0;
S_816_2: /* 3 */
S_742_0: /* 2 */
		if (!(((((int)now.veh_road[0])==1)&&(((int)now.veh_dir[0])==0))))
			goto S_816_3;
S_743_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n0 = 1;
#ifdef VAR_RANGES
		logval(":init::src_n0", ((int)((P2 *)_this)->_8_5_1_src_n0));
#endif
		;
S_744_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d0 = 1;
#ifdef VAR_RANGES
		logval(":init::src_d0", ((int)((P2 *)_this)->_8_5_1_src_d0));
#endif
		;
		goto S_817_0;
S_816_3: /* 3 */
S_745_0: /* 2 */
		if (!(((((int)now.veh_road[0])==1)&&(((int)now.veh_dir[0])==1))))
			goto S_816_4;
S_746_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n0 = 2;
#ifdef VAR_RANGES
		logval(":init::src_n0", ((int)((P2 *)_this)->_8_5_1_src_n0));
#endif
		;
S_747_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d0 = 3;
#ifdef VAR_RANGES
		logval(":init::src_d0", ((int)((P2 *)_this)->_8_5_1_src_d0));
#endif
		;
		goto S_817_0;
S_816_4: /* 3 */
S_748_0: /* 2 */
		if (!(((((int)now.veh_road[0])==2)&&(((int)now.veh_dir[0])==0))))
			goto S_816_5;
S_749_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n0 = 3;
#ifdef VAR_RANGES
		logval(":init::src_n0", ((int)((P2 *)_this)->_8_5_1_src_n0));
#endif
		;
S_750_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d0 = 1;
#ifdef VAR_RANGES
		logval(":init::src_d0", ((int)((P2 *)_this)->_8_5_1_src_d0));
#endif
		;
		goto S_817_0;
S_816_5: /* 3 */
S_751_0: /* 2 */
		if (!(((((int)now.veh_road[0])==2)&&(((int)now.veh_dir[0])==1))))
			goto S_816_6;
S_752_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n0 = 4;
#ifdef VAR_RANGES
		logval(":init::src_n0", ((int)((P2 *)_this)->_8_5_1_src_n0));
#endif
		;
S_753_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d0 = 3;
#ifdef VAR_RANGES
		logval(":init::src_d0", ((int)((P2 *)_this)->_8_5_1_src_d0));
#endif
		;
		goto S_817_0;
S_816_6: /* 3 */
S_754_0: /* 2 */
		if (!(((((int)now.veh_road[0])==3)&&(((int)now.veh_dir[0])==0))))
			goto S_816_7;
S_755_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n0 = 4;
#ifdef VAR_RANGES
		logval(":init::src_n0", ((int)((P2 *)_this)->_8_5_1_src_n0));
#endif
		;
S_756_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d0 = 1;
#ifdef VAR_RANGES
		logval(":init::src_d0", ((int)((P2 *)_this)->_8_5_1_src_d0));
#endif
		;
		goto S_817_0;
S_816_7: /* 3 */
S_757_0: /* 2 */
		if (!(((((int)now.veh_road[0])==3)&&(((int)now.veh_dir[0])==1))))
			goto S_816_8;
S_758_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n0 = 5;
#ifdef VAR_RANGES
		logval(":init::src_n0", ((int)((P2 *)_this)->_8_5_1_src_n0));
#endif
		;
S_759_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d0 = 3;
#ifdef VAR_RANGES
		logval(":init::src_d0", ((int)((P2 *)_this)->_8_5_1_src_d0));
#endif
		;
		goto S_817_0;
S_816_8: /* 3 */
S_760_0: /* 2 */
		if (!(((((int)now.veh_road[0])==4)&&(((int)now.veh_dir[0])==0))))
			goto S_816_9;
S_761_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n0 = 6;
#ifdef VAR_RANGES
		logval(":init::src_n0", ((int)((P2 *)_this)->_8_5_1_src_n0));
#endif
		;
S_762_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d0 = 1;
#ifdef VAR_RANGES
		logval(":init::src_d0", ((int)((P2 *)_this)->_8_5_1_src_d0));
#endif
		;
		goto S_817_0;
S_816_9: /* 3 */
S_763_0: /* 2 */
		if (!(((((int)now.veh_road[0])==4)&&(((int)now.veh_dir[0])==1))))
			goto S_816_10;
S_764_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n0 = 7;
#ifdef VAR_RANGES
		logval(":init::src_n0", ((int)((P2 *)_this)->_8_5_1_src_n0));
#endif
		;
S_765_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d0 = 3;
#ifdef VAR_RANGES
		logval(":init::src_d0", ((int)((P2 *)_this)->_8_5_1_src_d0));
#endif
		;
		goto S_817_0;
S_816_10: /* 3 */
S_766_0: /* 2 */
		if (!(((((int)now.veh_road[0])==5)&&(((int)now.veh_dir[0])==0))))
			goto S_816_11;
S_767_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n0 = 7;
#ifdef VAR_RANGES
		logval(":init::src_n0", ((int)((P2 *)_this)->_8_5_1_src_n0));
#endif
		;
S_768_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d0 = 1;
#ifdef VAR_RANGES
		logval(":init::src_d0", ((int)((P2 *)_this)->_8_5_1_src_d0));
#endif
		;
		goto S_817_0;
S_816_11: /* 3 */
S_769_0: /* 2 */
		if (!(((((int)now.veh_road[0])==5)&&(((int)now.veh_dir[0])==1))))
			goto S_816_12;
S_770_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n0 = 8;
#ifdef VAR_RANGES
		logval(":init::src_n0", ((int)((P2 *)_this)->_8_5_1_src_n0));
#endif
		;
S_771_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d0 = 3;
#ifdef VAR_RANGES
		logval(":init::src_d0", ((int)((P2 *)_this)->_8_5_1_src_d0));
#endif
		;
		goto S_817_0;
S_816_12: /* 3 */
S_772_0: /* 2 */
		if (!(((((int)now.veh_road[0])==6)&&(((int)now.veh_dir[0])==0))))
			goto S_816_13;
S_773_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n0 = 0;
#ifdef VAR_RANGES
		logval(":init::src_n0", ((int)((P2 *)_this)->_8_5_1_src_n0));
#endif
		;
S_774_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d0 = 2;
#ifdef VAR_RANGES
		logval(":init::src_d0", ((int)((P2 *)_this)->_8_5_1_src_d0));
#endif
		;
		goto S_817_0;
S_816_13: /* 3 */
S_775_0: /* 2 */
		if (!(((((int)now.veh_road[0])==6)&&(((int)now.veh_dir[0])==1))))
			goto S_816_14;
S_776_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n0 = 3;
#ifdef VAR_RANGES
		logval(":init::src_n0", ((int)((P2 *)_this)->_8_5_1_src_n0));
#endif
		;
S_777_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d0 = 0;
#ifdef VAR_RANGES
		logval(":init::src_d0", ((int)((P2 *)_this)->_8_5_1_src_d0));
#endif
		;
		goto S_817_0;
S_816_14: /* 3 */
S_778_0: /* 2 */
		if (!(((((int)now.veh_road[0])==7)&&(((int)now.veh_dir[0])==0))))
			goto S_816_15;
S_779_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n0 = 1;
#ifdef VAR_RANGES
		logval(":init::src_n0", ((int)((P2 *)_this)->_8_5_1_src_n0));
#endif
		;
S_780_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d0 = 2;
#ifdef VAR_RANGES
		logval(":init::src_d0", ((int)((P2 *)_this)->_8_5_1_src_d0));
#endif
		;
		goto S_817_0;
S_816_15: /* 3 */
S_781_0: /* 2 */
		if (!(((((int)now.veh_road[0])==7)&&(((int)now.veh_dir[0])==1))))
			goto S_816_16;
S_782_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n0 = 4;
#ifdef VAR_RANGES
		logval(":init::src_n0", ((int)((P2 *)_this)->_8_5_1_src_n0));
#endif
		;
S_783_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d0 = 0;
#ifdef VAR_RANGES
		logval(":init::src_d0", ((int)((P2 *)_this)->_8_5_1_src_d0));
#endif
		;
		goto S_817_0;
S_816_16: /* 3 */
S_784_0: /* 2 */
		if (!(((((int)now.veh_road[0])==8)&&(((int)now.veh_dir[0])==0))))
			goto S_816_17;
S_785_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n0 = 2;
#ifdef VAR_RANGES
		logval(":init::src_n0", ((int)((P2 *)_this)->_8_5_1_src_n0));
#endif
		;
S_786_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d0 = 2;
#ifdef VAR_RANGES
		logval(":init::src_d0", ((int)((P2 *)_this)->_8_5_1_src_d0));
#endif
		;
		goto S_817_0;
S_816_17: /* 3 */
S_787_0: /* 2 */
		if (!(((((int)now.veh_road[0])==8)&&(((int)now.veh_dir[0])==1))))
			goto S_816_18;
S_788_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n0 = 5;
#ifdef VAR_RANGES
		logval(":init::src_n0", ((int)((P2 *)_this)->_8_5_1_src_n0));
#endif
		;
S_789_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d0 = 0;
#ifdef VAR_RANGES
		logval(":init::src_d0", ((int)((P2 *)_this)->_8_5_1_src_d0));
#endif
		;
		goto S_817_0;
S_816_18: /* 3 */
S_790_0: /* 2 */
		if (!(((((int)now.veh_road[0])==9)&&(((int)now.veh_dir[0])==0))))
			goto S_816_19;
S_791_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n0 = 3;
#ifdef VAR_RANGES
		logval(":init::src_n0", ((int)((P2 *)_this)->_8_5_1_src_n0));
#endif
		;
S_792_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d0 = 2;
#ifdef VAR_RANGES
		logval(":init::src_d0", ((int)((P2 *)_this)->_8_5_1_src_d0));
#endif
		;
		goto S_817_0;
S_816_19: /* 3 */
S_793_0: /* 2 */
		if (!(((((int)now.veh_road[0])==9)&&(((int)now.veh_dir[0])==1))))
			goto S_816_20;
S_794_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n0 = 6;
#ifdef VAR_RANGES
		logval(":init::src_n0", ((int)((P2 *)_this)->_8_5_1_src_n0));
#endif
		;
S_795_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d0 = 0;
#ifdef VAR_RANGES
		logval(":init::src_d0", ((int)((P2 *)_this)->_8_5_1_src_d0));
#endif
		;
		goto S_817_0;
S_816_20: /* 3 */
S_796_0: /* 2 */
		if (!(((((int)now.veh_road[0])==10)&&(((int)now.veh_dir[0])==0))))
			goto S_816_21;
S_797_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n0 = 4;
#ifdef VAR_RANGES
		logval(":init::src_n0", ((int)((P2 *)_this)->_8_5_1_src_n0));
#endif
		;
S_798_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d0 = 2;
#ifdef VAR_RANGES
		logval(":init::src_d0", ((int)((P2 *)_this)->_8_5_1_src_d0));
#endif
		;
		goto S_817_0;
S_816_21: /* 3 */
S_799_0: /* 2 */
		if (!(((((int)now.veh_road[0])==10)&&(((int)now.veh_dir[0])==1))))
			goto S_816_22;
S_800_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n0 = 7;
#ifdef VAR_RANGES
		logval(":init::src_n0", ((int)((P2 *)_this)->_8_5_1_src_n0));
#endif
		;
S_801_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d0 = 0;
#ifdef VAR_RANGES
		logval(":init::src_d0", ((int)((P2 *)_this)->_8_5_1_src_d0));
#endif
		;
		goto S_817_0;
S_816_22: /* 3 */
S_802_0: /* 2 */
		if (!(((((int)now.veh_road[0])==11)&&(((int)now.veh_dir[0])==0))))
			goto S_816_23;
S_803_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n0 = 5;
#ifdef VAR_RANGES
		logval(":init::src_n0", ((int)((P2 *)_this)->_8_5_1_src_n0));
#endif
		;
S_804_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d0 = 2;
#ifdef VAR_RANGES
		logval(":init::src_d0", ((int)((P2 *)_this)->_8_5_1_src_d0));
#endif
		;
		goto S_817_0;
S_816_23: /* 3 */
S_805_0: /* 2 */
		if (!(((((int)now.veh_road[0])==11)&&(((int)now.veh_dir[0])==1))))
			goto S_816_24;
S_806_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n0 = 8;
#ifdef VAR_RANGES
		logval(":init::src_n0", ((int)((P2 *)_this)->_8_5_1_src_n0));
#endif
		;
S_807_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d0 = 0;
#ifdef VAR_RANGES
		logval(":init::src_d0", ((int)((P2 *)_this)->_8_5_1_src_d0));
#endif
		;
		goto S_817_0;
S_816_24: /* 3 */
S_808_0: /* 2 */
		if (!(((((int)now.veh_road[0])==12)&&(((int)now.veh_dir[0])==0))))
			goto S_816_25;
S_809_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n0 = 0;
#ifdef VAR_RANGES
		logval(":init::src_n0", ((int)((P2 *)_this)->_8_5_1_src_n0));
#endif
		;
S_810_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d0 = 3;
#ifdef VAR_RANGES
		logval(":init::src_d0", ((int)((P2 *)_this)->_8_5_1_src_d0));
#endif
		;
		goto S_817_0;
S_816_25: /* 3 */
S_811_0: /* 2 */
		if (!(((((int)now.veh_road[0])==12)&&(((int)now.veh_dir[0])==1))))
			goto S_816_26;
S_812_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n0 = 255;
#ifdef VAR_RANGES
		logval(":init::src_n0", ((int)((P2 *)_this)->_8_5_1_src_n0));
#endif
		;
S_813_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d0 = 255;
#ifdef VAR_RANGES
		logval(":init::src_d0", ((int)((P2 *)_this)->_8_5_1_src_d0));
#endif
		;
		goto S_817_0;
S_816_26: /* 3 */
S_814_0: /* 2 */
		/* else */;
S_815_0: /* 2 */
		if (!(1))
			Uerror("block in d_step seq");
		goto S_817_0;
S_816_27: /* 3 */
		Uerror("blocking sel in d_step (nr.4, near line 449)");
S_817_0: /* 2 */
S_822_0: /* 2 */
S_818_0: /* 2 */
		if (!(((((int)((P2 *)_this)->_8_5_1_src_n0)!=255)&&(((int)now.light_green[ Index(((int)((P2 *)_this)->_8_5_1_src_n0), 10) ])!=((int)((P2 *)_this)->_8_5_1_src_d0)))))
			goto S_822_1;
S_819_0: /* 2 */
		now.red_violation = 1;
#ifdef VAR_RANGES
		logval("red_violation", ((int)now.red_violation));
#endif
		;
		goto S_823_0;
S_822_1: /* 3 */
S_820_0: /* 2 */
		/* else */;
S_821_0: /* 2 */
		if (!(1))
			Uerror("block in d_step seq");
		goto S_823_0;
S_822_2: /* 3 */
		Uerror("blocking sel in d_step (nr.5, near line 478)");
S_823_0: /* 2 */
		goto S_827_0;
S_826_1: /* 3 */
S_824_0: /* 2 */
		/* else */;
S_825_0: /* 2 */
		if (!(1))
			Uerror("block in d_step seq");
		goto S_827_0;
S_826_2: /* 3 */
		Uerror("blocking sel in d_step (nr.6, near line 445)");
S_827_0: /* 2 */
S_921_0: /* 2 */
S_828_0: /* 2 */
		if (!((((((int)now.veh_mode[1])==1)&&(((int)now.veh_slot[1])==0))&&((int)now.moved_this_step[1]))))
			goto S_921_1;
S_829_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n1 = 255;
#ifdef VAR_RANGES
		logval(":init::src_n1", ((int)((P2 *)_this)->_8_5_1_src_n1));
#endif
		;
S_830_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d1 = 255;
#ifdef VAR_RANGES
		logval(":init::src_d1", ((int)((P2 *)_this)->_8_5_1_src_d1));
#endif
		;
S_911_0: /* 2 */
S_831_0: /* 2 */
		if (!(((((int)now.veh_road[1])==0)&&(((int)now.veh_dir[1])==0))))
			goto S_911_1;
S_832_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n1 = 0;
#ifdef VAR_RANGES
		logval(":init::src_n1", ((int)((P2 *)_this)->_8_5_1_src_n1));
#endif
		;
S_833_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d1 = 1;
#ifdef VAR_RANGES
		logval(":init::src_d1", ((int)((P2 *)_this)->_8_5_1_src_d1));
#endif
		;
		goto S_912_0;
S_911_1: /* 3 */
S_834_0: /* 2 */
		if (!(((((int)now.veh_road[1])==0)&&(((int)now.veh_dir[1])==1))))
			goto S_911_2;
S_835_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n1 = 1;
#ifdef VAR_RANGES
		logval(":init::src_n1", ((int)((P2 *)_this)->_8_5_1_src_n1));
#endif
		;
S_836_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d1 = 3;
#ifdef VAR_RANGES
		logval(":init::src_d1", ((int)((P2 *)_this)->_8_5_1_src_d1));
#endif
		;
		goto S_912_0;
S_911_2: /* 3 */
S_837_0: /* 2 */
		if (!(((((int)now.veh_road[1])==1)&&(((int)now.veh_dir[1])==0))))
			goto S_911_3;
S_838_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n1 = 1;
#ifdef VAR_RANGES
		logval(":init::src_n1", ((int)((P2 *)_this)->_8_5_1_src_n1));
#endif
		;
S_839_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d1 = 1;
#ifdef VAR_RANGES
		logval(":init::src_d1", ((int)((P2 *)_this)->_8_5_1_src_d1));
#endif
		;
		goto S_912_0;
S_911_3: /* 3 */
S_840_0: /* 2 */
		if (!(((((int)now.veh_road[1])==1)&&(((int)now.veh_dir[1])==1))))
			goto S_911_4;
S_841_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n1 = 2;
#ifdef VAR_RANGES
		logval(":init::src_n1", ((int)((P2 *)_this)->_8_5_1_src_n1));
#endif
		;
S_842_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d1 = 3;
#ifdef VAR_RANGES
		logval(":init::src_d1", ((int)((P2 *)_this)->_8_5_1_src_d1));
#endif
		;
		goto S_912_0;
S_911_4: /* 3 */
S_843_0: /* 2 */
		if (!(((((int)now.veh_road[1])==2)&&(((int)now.veh_dir[1])==0))))
			goto S_911_5;
S_844_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n1 = 3;
#ifdef VAR_RANGES
		logval(":init::src_n1", ((int)((P2 *)_this)->_8_5_1_src_n1));
#endif
		;
S_845_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d1 = 1;
#ifdef VAR_RANGES
		logval(":init::src_d1", ((int)((P2 *)_this)->_8_5_1_src_d1));
#endif
		;
		goto S_912_0;
S_911_5: /* 3 */
S_846_0: /* 2 */
		if (!(((((int)now.veh_road[1])==2)&&(((int)now.veh_dir[1])==1))))
			goto S_911_6;
S_847_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n1 = 4;
#ifdef VAR_RANGES
		logval(":init::src_n1", ((int)((P2 *)_this)->_8_5_1_src_n1));
#endif
		;
S_848_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d1 = 3;
#ifdef VAR_RANGES
		logval(":init::src_d1", ((int)((P2 *)_this)->_8_5_1_src_d1));
#endif
		;
		goto S_912_0;
S_911_6: /* 3 */
S_849_0: /* 2 */
		if (!(((((int)now.veh_road[1])==3)&&(((int)now.veh_dir[1])==0))))
			goto S_911_7;
S_850_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n1 = 4;
#ifdef VAR_RANGES
		logval(":init::src_n1", ((int)((P2 *)_this)->_8_5_1_src_n1));
#endif
		;
S_851_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d1 = 1;
#ifdef VAR_RANGES
		logval(":init::src_d1", ((int)((P2 *)_this)->_8_5_1_src_d1));
#endif
		;
		goto S_912_0;
S_911_7: /* 3 */
S_852_0: /* 2 */
		if (!(((((int)now.veh_road[1])==3)&&(((int)now.veh_dir[1])==1))))
			goto S_911_8;
S_853_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n1 = 5;
#ifdef VAR_RANGES
		logval(":init::src_n1", ((int)((P2 *)_this)->_8_5_1_src_n1));
#endif
		;
S_854_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d1 = 3;
#ifdef VAR_RANGES
		logval(":init::src_d1", ((int)((P2 *)_this)->_8_5_1_src_d1));
#endif
		;
		goto S_912_0;
S_911_8: /* 3 */
S_855_0: /* 2 */
		if (!(((((int)now.veh_road[1])==4)&&(((int)now.veh_dir[1])==0))))
			goto S_911_9;
S_856_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n1 = 6;
#ifdef VAR_RANGES
		logval(":init::src_n1", ((int)((P2 *)_this)->_8_5_1_src_n1));
#endif
		;
S_857_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d1 = 1;
#ifdef VAR_RANGES
		logval(":init::src_d1", ((int)((P2 *)_this)->_8_5_1_src_d1));
#endif
		;
		goto S_912_0;
S_911_9: /* 3 */
S_858_0: /* 2 */
		if (!(((((int)now.veh_road[1])==4)&&(((int)now.veh_dir[1])==1))))
			goto S_911_10;
S_859_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n1 = 7;
#ifdef VAR_RANGES
		logval(":init::src_n1", ((int)((P2 *)_this)->_8_5_1_src_n1));
#endif
		;
S_860_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d1 = 3;
#ifdef VAR_RANGES
		logval(":init::src_d1", ((int)((P2 *)_this)->_8_5_1_src_d1));
#endif
		;
		goto S_912_0;
S_911_10: /* 3 */
S_861_0: /* 2 */
		if (!(((((int)now.veh_road[1])==5)&&(((int)now.veh_dir[1])==0))))
			goto S_911_11;
S_862_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n1 = 7;
#ifdef VAR_RANGES
		logval(":init::src_n1", ((int)((P2 *)_this)->_8_5_1_src_n1));
#endif
		;
S_863_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d1 = 1;
#ifdef VAR_RANGES
		logval(":init::src_d1", ((int)((P2 *)_this)->_8_5_1_src_d1));
#endif
		;
		goto S_912_0;
S_911_11: /* 3 */
S_864_0: /* 2 */
		if (!(((((int)now.veh_road[1])==5)&&(((int)now.veh_dir[1])==1))))
			goto S_911_12;
S_865_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n1 = 8;
#ifdef VAR_RANGES
		logval(":init::src_n1", ((int)((P2 *)_this)->_8_5_1_src_n1));
#endif
		;
S_866_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d1 = 3;
#ifdef VAR_RANGES
		logval(":init::src_d1", ((int)((P2 *)_this)->_8_5_1_src_d1));
#endif
		;
		goto S_912_0;
S_911_12: /* 3 */
S_867_0: /* 2 */
		if (!(((((int)now.veh_road[1])==6)&&(((int)now.veh_dir[1])==0))))
			goto S_911_13;
S_868_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n1 = 0;
#ifdef VAR_RANGES
		logval(":init::src_n1", ((int)((P2 *)_this)->_8_5_1_src_n1));
#endif
		;
S_869_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d1 = 2;
#ifdef VAR_RANGES
		logval(":init::src_d1", ((int)((P2 *)_this)->_8_5_1_src_d1));
#endif
		;
		goto S_912_0;
S_911_13: /* 3 */
S_870_0: /* 2 */
		if (!(((((int)now.veh_road[1])==6)&&(((int)now.veh_dir[1])==1))))
			goto S_911_14;
S_871_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n1 = 3;
#ifdef VAR_RANGES
		logval(":init::src_n1", ((int)((P2 *)_this)->_8_5_1_src_n1));
#endif
		;
S_872_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d1 = 0;
#ifdef VAR_RANGES
		logval(":init::src_d1", ((int)((P2 *)_this)->_8_5_1_src_d1));
#endif
		;
		goto S_912_0;
S_911_14: /* 3 */
S_873_0: /* 2 */
		if (!(((((int)now.veh_road[1])==7)&&(((int)now.veh_dir[1])==0))))
			goto S_911_15;
S_874_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n1 = 1;
#ifdef VAR_RANGES
		logval(":init::src_n1", ((int)((P2 *)_this)->_8_5_1_src_n1));
#endif
		;
S_875_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d1 = 2;
#ifdef VAR_RANGES
		logval(":init::src_d1", ((int)((P2 *)_this)->_8_5_1_src_d1));
#endif
		;
		goto S_912_0;
S_911_15: /* 3 */
S_876_0: /* 2 */
		if (!(((((int)now.veh_road[1])==7)&&(((int)now.veh_dir[1])==1))))
			goto S_911_16;
S_877_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n1 = 4;
#ifdef VAR_RANGES
		logval(":init::src_n1", ((int)((P2 *)_this)->_8_5_1_src_n1));
#endif
		;
S_878_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d1 = 0;
#ifdef VAR_RANGES
		logval(":init::src_d1", ((int)((P2 *)_this)->_8_5_1_src_d1));
#endif
		;
		goto S_912_0;
S_911_16: /* 3 */
S_879_0: /* 2 */
		if (!(((((int)now.veh_road[1])==8)&&(((int)now.veh_dir[1])==0))))
			goto S_911_17;
S_880_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n1 = 2;
#ifdef VAR_RANGES
		logval(":init::src_n1", ((int)((P2 *)_this)->_8_5_1_src_n1));
#endif
		;
S_881_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d1 = 2;
#ifdef VAR_RANGES
		logval(":init::src_d1", ((int)((P2 *)_this)->_8_5_1_src_d1));
#endif
		;
		goto S_912_0;
S_911_17: /* 3 */
S_882_0: /* 2 */
		if (!(((((int)now.veh_road[1])==8)&&(((int)now.veh_dir[1])==1))))
			goto S_911_18;
S_883_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n1 = 5;
#ifdef VAR_RANGES
		logval(":init::src_n1", ((int)((P2 *)_this)->_8_5_1_src_n1));
#endif
		;
S_884_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d1 = 0;
#ifdef VAR_RANGES
		logval(":init::src_d1", ((int)((P2 *)_this)->_8_5_1_src_d1));
#endif
		;
		goto S_912_0;
S_911_18: /* 3 */
S_885_0: /* 2 */
		if (!(((((int)now.veh_road[1])==9)&&(((int)now.veh_dir[1])==0))))
			goto S_911_19;
S_886_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n1 = 3;
#ifdef VAR_RANGES
		logval(":init::src_n1", ((int)((P2 *)_this)->_8_5_1_src_n1));
#endif
		;
S_887_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d1 = 2;
#ifdef VAR_RANGES
		logval(":init::src_d1", ((int)((P2 *)_this)->_8_5_1_src_d1));
#endif
		;
		goto S_912_0;
S_911_19: /* 3 */
S_888_0: /* 2 */
		if (!(((((int)now.veh_road[1])==9)&&(((int)now.veh_dir[1])==1))))
			goto S_911_20;
S_889_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n1 = 6;
#ifdef VAR_RANGES
		logval(":init::src_n1", ((int)((P2 *)_this)->_8_5_1_src_n1));
#endif
		;
S_890_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d1 = 0;
#ifdef VAR_RANGES
		logval(":init::src_d1", ((int)((P2 *)_this)->_8_5_1_src_d1));
#endif
		;
		goto S_912_0;
S_911_20: /* 3 */
S_891_0: /* 2 */
		if (!(((((int)now.veh_road[1])==10)&&(((int)now.veh_dir[1])==0))))
			goto S_911_21;
S_892_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n1 = 4;
#ifdef VAR_RANGES
		logval(":init::src_n1", ((int)((P2 *)_this)->_8_5_1_src_n1));
#endif
		;
S_893_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d1 = 2;
#ifdef VAR_RANGES
		logval(":init::src_d1", ((int)((P2 *)_this)->_8_5_1_src_d1));
#endif
		;
		goto S_912_0;
S_911_21: /* 3 */
S_894_0: /* 2 */
		if (!(((((int)now.veh_road[1])==10)&&(((int)now.veh_dir[1])==1))))
			goto S_911_22;
S_895_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n1 = 7;
#ifdef VAR_RANGES
		logval(":init::src_n1", ((int)((P2 *)_this)->_8_5_1_src_n1));
#endif
		;
S_896_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d1 = 0;
#ifdef VAR_RANGES
		logval(":init::src_d1", ((int)((P2 *)_this)->_8_5_1_src_d1));
#endif
		;
		goto S_912_0;
S_911_22: /* 3 */
S_897_0: /* 2 */
		if (!(((((int)now.veh_road[1])==11)&&(((int)now.veh_dir[1])==0))))
			goto S_911_23;
S_898_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n1 = 5;
#ifdef VAR_RANGES
		logval(":init::src_n1", ((int)((P2 *)_this)->_8_5_1_src_n1));
#endif
		;
S_899_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d1 = 2;
#ifdef VAR_RANGES
		logval(":init::src_d1", ((int)((P2 *)_this)->_8_5_1_src_d1));
#endif
		;
		goto S_912_0;
S_911_23: /* 3 */
S_900_0: /* 2 */
		if (!(((((int)now.veh_road[1])==11)&&(((int)now.veh_dir[1])==1))))
			goto S_911_24;
S_901_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n1 = 8;
#ifdef VAR_RANGES
		logval(":init::src_n1", ((int)((P2 *)_this)->_8_5_1_src_n1));
#endif
		;
S_902_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d1 = 0;
#ifdef VAR_RANGES
		logval(":init::src_d1", ((int)((P2 *)_this)->_8_5_1_src_d1));
#endif
		;
		goto S_912_0;
S_911_24: /* 3 */
S_903_0: /* 2 */
		if (!(((((int)now.veh_road[1])==12)&&(((int)now.veh_dir[1])==0))))
			goto S_911_25;
S_904_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n1 = 0;
#ifdef VAR_RANGES
		logval(":init::src_n1", ((int)((P2 *)_this)->_8_5_1_src_n1));
#endif
		;
S_905_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d1 = 3;
#ifdef VAR_RANGES
		logval(":init::src_d1", ((int)((P2 *)_this)->_8_5_1_src_d1));
#endif
		;
		goto S_912_0;
S_911_25: /* 3 */
S_906_0: /* 2 */
		if (!(((((int)now.veh_road[1])==12)&&(((int)now.veh_dir[1])==1))))
			goto S_911_26;
S_907_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_n1 = 255;
#ifdef VAR_RANGES
		logval(":init::src_n1", ((int)((P2 *)_this)->_8_5_1_src_n1));
#endif
		;
S_908_0: /* 2 */
		((P2 *)_this)->_8_5_1_src_d1 = 255;
#ifdef VAR_RANGES
		logval(":init::src_d1", ((int)((P2 *)_this)->_8_5_1_src_d1));
#endif
		;
		goto S_912_0;
S_911_26: /* 3 */
S_909_0: /* 2 */
		/* else */;
S_910_0: /* 2 */
		if (!(1))
			Uerror("block in d_step seq");
		goto S_912_0;
S_911_27: /* 3 */
		Uerror("blocking sel in d_step (nr.7, near line 489)");
S_912_0: /* 2 */
S_917_0: /* 2 */
S_913_0: /* 2 */
		if (!(((((int)((P2 *)_this)->_8_5_1_src_n1)!=255)&&(((int)now.light_green[ Index(((int)((P2 *)_this)->_8_5_1_src_n1), 10) ])!=((int)((P2 *)_this)->_8_5_1_src_d1)))))
			goto S_917_1;
S_914_0: /* 2 */
		now.red_violation = 1;
#ifdef VAR_RANGES
		logval("red_violation", ((int)now.red_violation));
#endif
		;
		goto S_918_0;
S_917_1: /* 3 */
S_915_0: /* 2 */
		/* else */;
S_916_0: /* 2 */
		if (!(1))
			Uerror("block in d_step seq");
		goto S_918_0;
S_917_2: /* 3 */
		Uerror("blocking sel in d_step (nr.8, near line 518)");
S_918_0: /* 2 */
		goto S_922_0;
S_921_1: /* 3 */
S_919_0: /* 2 */
		/* else */;
S_920_0: /* 2 */
		if (!(1))
			Uerror("block in d_step seq");
		goto S_922_0;
S_921_2: /* 3 */
		Uerror("blocking sel in d_step (nr.9, near line 485)");
S_922_0: /* 2 */
S_927_0: /* 2 */
S_923_0: /* 2 */
		if (!(((((int)now.veh_mode[0])==1)&&(((int)now.road_slots[ Index((((((int)now.veh_road[0])*(2*3))+(((int)now.veh_dir[0])*3))+((int)now.veh_slot[0])), 78) ])!=1))))
			goto S_927_1;
S_924_0: /* 2 */
		now.opposite_direction_violation = 1;
#ifdef VAR_RANGES
		logval("opposite_direction_violation", ((int)now.opposite_direction_violation));
#endif
		;
		goto S_928_0;
S_927_1: /* 3 */
S_925_0: /* 2 */
		/* else */;
S_926_0: /* 2 */
		if (!(1))
			Uerror("block in d_step seq");
		goto S_928_0;
S_927_2: /* 3 */
		Uerror("blocking sel in d_step (nr.10, near line 527)");
S_928_0: /* 2 */
S_933_0: /* 2 */
S_929_0: /* 2 */
		if (!(((((int)now.veh_mode[1])==1)&&(((int)now.road_slots[ Index((((((int)now.veh_road[1])*(2*3))+(((int)now.veh_dir[1])*3))+((int)now.veh_slot[1])), 78) ])!=2))))
			goto S_933_1;
S_930_0: /* 2 */
		now.opposite_direction_violation = 1;
#ifdef VAR_RANGES
		logval("opposite_direction_violation", ((int)now.opposite_direction_violation));
#endif
		;
		goto S_934_0;
S_933_1: /* 3 */
S_931_0: /* 2 */
		/* else */;
S_932_0: /* 2 */
		if (!(1))
			Uerror("block in d_step seq");
		goto S_934_0;
S_933_2: /* 3 */
		Uerror("blocking sel in d_step (nr.11, near line 532)");
S_934_0: /* 2 */
		goto S_937_0;
S_937_0: /* 1 */

#if defined(C_States) && (HAS_TRACK==1)
		c_update((uchar *) &(now.c_state[0]));
#endif
		_m = 3; goto P999;

	case 44: // STATE 339 - phase_c_model.pml:976 - [assert(!(collision))] (0:0:0 - 1)
		IfNotBlocked
		reached[2][339] = 1;
		spin_assert( !(((int)now.collision)), " !(collision)", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 45: // STATE 340 - phase_c_model.pml:977 - [assert(!(red_violation))] (0:0:0 - 1)
		IfNotBlocked
		reached[2][340] = 1;
		spin_assert( !(((int)now.red_violation)), " !(red_violation)", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 46: // STATE 341 - phase_c_model.pml:978 - [assert(!(uturn_violation))] (0:0:0 - 1)
		IfNotBlocked
		reached[2][341] = 1;
		spin_assert( !(((int)now.uturn_violation)), " !(uturn_violation)", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 47: // STATE 342 - phase_c_model.pml:979 - [assert(!(opposite_direction_violation))] (0:0:0 - 1)
		IfNotBlocked
		reached[2][342] = 1;
		spin_assert( !(((int)now.opposite_direction_violation)), " !(opposite_direction_violation)", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 48: // STATE 343 - phase_c_model.pml:982 - [assert((crossing_count[0]<=1))] (0:0:0 - 1)
		IfNotBlocked
		reached[2][343] = 1;
		spin_assert((((int)now.crossing_count[0])<=1), "(crossing_count[0]<=1)", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 49: // STATE 344 - phase_c_model.pml:983 - [assert((crossing_count[1]<=1))] (0:0:0 - 1)
		IfNotBlocked
		reached[2][344] = 1;
		spin_assert((((int)now.crossing_count[1])<=1), "(crossing_count[1]<=1)", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 50: // STATE 345 - phase_c_model.pml:984 - [assert((crossing_count[2]<=1))] (0:0:0 - 1)
		IfNotBlocked
		reached[2][345] = 1;
		spin_assert((((int)now.crossing_count[2])<=1), "(crossing_count[2]<=1)", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 51: // STATE 346 - phase_c_model.pml:985 - [assert((crossing_count[3]<=1))] (0:0:0 - 1)
		IfNotBlocked
		reached[2][346] = 1;
		spin_assert((((int)now.crossing_count[3])<=1), "(crossing_count[3]<=1)", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 52: // STATE 347 - phase_c_model.pml:986 - [assert((crossing_count[4]<=1))] (0:0:0 - 1)
		IfNotBlocked
		reached[2][347] = 1;
		spin_assert((((int)now.crossing_count[4])<=1), "(crossing_count[4]<=1)", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 53: // STATE 348 - phase_c_model.pml:987 - [assert((crossing_count[5]<=1))] (0:0:0 - 1)
		IfNotBlocked
		reached[2][348] = 1;
		spin_assert((((int)now.crossing_count[5])<=1), "(crossing_count[5]<=1)", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 54: // STATE 349 - phase_c_model.pml:988 - [assert((crossing_count[6]<=1))] (0:0:0 - 1)
		IfNotBlocked
		reached[2][349] = 1;
		spin_assert((((int)now.crossing_count[6])<=1), "(crossing_count[6]<=1)", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 55: // STATE 350 - phase_c_model.pml:989 - [assert((crossing_count[7]<=1))] (0:0:0 - 1)
		IfNotBlocked
		reached[2][350] = 1;
		spin_assert((((int)now.crossing_count[7])<=1), "(crossing_count[7]<=1)", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 56: // STATE 351 - phase_c_model.pml:990 - [assert((crossing_count[8]<=1))] (0:0:0 - 1)
		IfNotBlocked
		reached[2][351] = 1;
		spin_assert((((int)now.crossing_count[8])<=1), "(crossing_count[8]<=1)", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 57: // STATE 352 - phase_c_model.pml:993 - [assert(((light_green[0]<=3)&&light_enabled[((0*4)+light_green[0])]))] (0:0:0 - 1)
		IfNotBlocked
		reached[2][352] = 1;
		spin_assert(((((int)now.light_green[0])<=3)&&((int)now.light_enabled[ Index(((0*4)+((int)now.light_green[0])), 40) ])), "((light_green[0]<=3)&&light_enabled[((0*4)+light_green[0])])", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 58: // STATE 353 - phase_c_model.pml:994 - [assert(((light_green[1]<=3)&&light_enabled[((1*4)+light_green[1])]))] (0:0:0 - 1)
		IfNotBlocked
		reached[2][353] = 1;
		spin_assert(((((int)now.light_green[1])<=3)&&((int)now.light_enabled[ Index(((1*4)+((int)now.light_green[1])), 40) ])), "((light_green[1]<=3)&&light_enabled[((1*4)+light_green[1])])", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 59: // STATE 354 - phase_c_model.pml:995 - [assert(((light_green[2]<=3)&&light_enabled[((2*4)+light_green[2])]))] (0:0:0 - 1)
		IfNotBlocked
		reached[2][354] = 1;
		spin_assert(((((int)now.light_green[2])<=3)&&((int)now.light_enabled[ Index(((2*4)+((int)now.light_green[2])), 40) ])), "((light_green[2]<=3)&&light_enabled[((2*4)+light_green[2])])", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 60: // STATE 355 - phase_c_model.pml:996 - [assert(((light_green[3]<=3)&&light_enabled[((3*4)+light_green[3])]))] (0:0:0 - 1)
		IfNotBlocked
		reached[2][355] = 1;
		spin_assert(((((int)now.light_green[3])<=3)&&((int)now.light_enabled[ Index(((3*4)+((int)now.light_green[3])), 40) ])), "((light_green[3]<=3)&&light_enabled[((3*4)+light_green[3])])", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 61: // STATE 356 - phase_c_model.pml:997 - [assert(((light_green[4]<=3)&&light_enabled[((4*4)+light_green[4])]))] (0:0:0 - 1)
		IfNotBlocked
		reached[2][356] = 1;
		spin_assert(((((int)now.light_green[4])<=3)&&((int)now.light_enabled[ Index(((4*4)+((int)now.light_green[4])), 40) ])), "((light_green[4]<=3)&&light_enabled[((4*4)+light_green[4])])", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 62: // STATE 357 - phase_c_model.pml:998 - [assert(((light_green[5]<=3)&&light_enabled[((5*4)+light_green[5])]))] (0:0:0 - 1)
		IfNotBlocked
		reached[2][357] = 1;
		spin_assert(((((int)now.light_green[5])<=3)&&((int)now.light_enabled[ Index(((5*4)+((int)now.light_green[5])), 40) ])), "((light_green[5]<=3)&&light_enabled[((5*4)+light_green[5])])", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 63: // STATE 358 - phase_c_model.pml:999 - [assert(((light_green[6]<=3)&&light_enabled[((6*4)+light_green[6])]))] (0:0:0 - 1)
		IfNotBlocked
		reached[2][358] = 1;
		spin_assert(((((int)now.light_green[6])<=3)&&((int)now.light_enabled[ Index(((6*4)+((int)now.light_green[6])), 40) ])), "((light_green[6]<=3)&&light_enabled[((6*4)+light_green[6])])", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 64: // STATE 359 - phase_c_model.pml:1000 - [assert(((light_green[7]<=3)&&light_enabled[((7*4)+light_green[7])]))] (0:0:0 - 1)
		IfNotBlocked
		reached[2][359] = 1;
		spin_assert(((((int)now.light_green[7])<=3)&&((int)now.light_enabled[ Index(((7*4)+((int)now.light_green[7])), 40) ])), "((light_green[7]<=3)&&light_enabled[((7*4)+light_green[7])])", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 65: // STATE 360 - phase_c_model.pml:1001 - [assert(((light_green[8]<=3)&&light_enabled[((8*4)+light_green[8])]))] (0:0:0 - 1)
		IfNotBlocked
		reached[2][360] = 1;
		spin_assert(((((int)now.light_green[8])<=3)&&((int)now.light_enabled[ Index(((8*4)+((int)now.light_green[8])), 40) ])), "((light_green[8]<=3)&&light_enabled[((8*4)+light_green[8])])", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 66: // STATE 361 - phase_c_model.pml:1005 - [((returned_A[0]&&returned_A[1]))] (0:0:0 - 1)
		IfNotBlocked
		reached[2][361] = 1;
		if (!((((int)now.returned_A[0])&&((int)now.returned_A[1]))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 67: // STATE 362 - phase_c_model.pml:1005 - [all_tours_done = 1] (0:0:1 - 1)
		IfNotBlocked
		reached[2][362] = 1;
		(trpt+1)->bup.oval = ((int)all_tours_done);
		all_tours_done = 1;
#ifdef VAR_RANGES
		logval("all_tours_done", ((int)all_tours_done));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 68: // STATE 364 - phase_c_model.pml:1006 - [(1)] (368:0:1 - 1)
		IfNotBlocked
		reached[2][364] = 1;
		if (!(1))
			continue;
		/* merge: .(goto)(368, 366, 368) */
		reached[2][366] = 1;
		;
		/* merge: tick_count = (tick_count+1)(368, 367, 368) */
		reached[2][367] = 1;
		(trpt+1)->bup.oval = ((int)((P2 *)_this)->tick_count);
		((P2 *)_this)->tick_count = (((int)((P2 *)_this)->tick_count)+1);
#ifdef VAR_RANGES
		logval(":init::tick_count", ((int)((P2 *)_this)->tick_count));
#endif
		;
		/* merge: .(goto)(0, 369, 368) */
		reached[2][369] = 1;
		;
		_m = 3; goto P999; /* 3 */
	case 69: // STATE 367 - phase_c_model.pml:1009 - [tick_count = (tick_count+1)] (0:368:1 - 3)
		IfNotBlocked
		reached[2][367] = 1;
		(trpt+1)->bup.oval = ((int)((P2 *)_this)->tick_count);
		((P2 *)_this)->tick_count = (((int)((P2 *)_this)->tick_count)+1);
#ifdef VAR_RANGES
		logval(":init::tick_count", ((int)((P2 *)_this)->tick_count));
#endif
		;
		/* merge: .(goto)(0, 369, 368) */
		reached[2][369] = 1;
		;
		_m = 3; goto P999; /* 1 */
	case 70: // STATE 371 - phase_c_model.pml:1011 - [-end-] (0:0:0 - 5)
		IfNotBlocked
		reached[2][371] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC VehicleFSM */
	case 71: // STATE 1 - phase_c_model.pml:562 - [tick_vehicle[vid]?dummy] (0:0:2 - 1)
		reached[1][1] = 1;
		if (boq != now.tick_vehicle[ Index(((int)((P1 *)_this)->vid), 2) ]) continue;
		if (q_len(now.tick_vehicle[ Index(((int)((P1 *)_this)->vid), 2) ]) == 0) continue;

		XX=1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = ((int)((P1 *)_this)->dummy);
		;
		((P1 *)_this)->dummy = qrecv(now.tick_vehicle[ Index(((int)((P1 *)_this)->vid), 2) ], XX-1, 0, 1);
#ifdef VAR_RANGES
		logval("VehicleFSM:dummy", ((int)((P1 *)_this)->dummy));
#endif
		;
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", now.tick_vehicle[ Index(((int)((P1 *)_this)->vid), 2) ]);
			sprintf(simtmp, "%d", ((int)((P1 *)_this)->dummy)); strcat(simvals, simtmp);
		}
#endif
		if (q_zero(now.tick_vehicle[ Index(((int)((P1 *)_this)->vid), 2) ]))
		{	boq = -1;
#ifndef NOFAIR
			if (fairness
			&& !(trpt->o_pm&32)
			&& (now._a_t&2)
			&&  now._cnt[now._a_t&1] == II+2)
			{	now._cnt[now._a_t&1] -= 1;
#ifdef VERI
				if (II == 1)
					now._cnt[now._a_t&1] = 1;
#endif
#ifdef DEBUG
			printf("%3ld: proc %d fairness ", depth, II);
			printf("Rule 2: --cnt to %d (%d)\n",
				now._cnt[now._a_t&1], now._a_t);
#endif
				trpt->o_pm |= (32|64);
			}
#endif

		};
		if (TstOnly) return 1; /* TT */
		/* dead 2: dummy */  (trpt+1)->bup.ovals[1] = ((P1 *)_this)->dummy;
#ifdef HAS_CODE
		if (!readtrail)
#endif
			((P1 *)_this)->dummy = 0;
		_m = 4; goto P999; /* 0 */
	case 72: // STATE 352 - phase_c_model.pml:563 - [D_STEP563]
		IfNotBlocked

		reached[1][352] = 1;
		reached[1][t->st] = 1;
		reached[1][tt] = 1;

		if (TstOnly) return 1;

		sv_save();
		S_243_0: /* 2 */
		((P1 *)_this)->_7_2_cur_node = 0;
#ifdef VAR_RANGES
		logval("VehicleFSM:cur_node", ((int)((P1 *)_this)->_7_2_cur_node));
#endif
		;
S_244_0: /* 2 */
		((P1 *)_this)->_7_2_next_node = 0;
#ifdef VAR_RANGES
		logval("VehicleFSM:next_node", ((int)((P1 *)_this)->_7_2_next_node));
#endif
		;
S_245_0: /* 2 */
		((P1 *)_this)->_7_2_cur_slot = 0;
#ifdef VAR_RANGES
		logval("VehicleFSM:cur_slot", ((int)((P1 *)_this)->_7_2_cur_slot));
#endif
		;
S_246_0: /* 2 */
		((P1 *)_this)->_7_2_out_dir = 0;
#ifdef VAR_RANGES
		logval("VehicleFSM:out_dir", ((int)((P1 *)_this)->_7_2_out_dir));
#endif
		;
S_247_0: /* 2 */
		((P1 *)_this)->_7_2_road_id = 0;
#ifdef VAR_RANGES
		logval("VehicleFSM:road_id", ((int)((P1 *)_this)->_7_2_road_id));
#endif
		;
S_248_0: /* 2 */
		((P1 *)_this)->_7_2_lane_dir = 0;
#ifdef VAR_RANGES
		logval("VehicleFSM:lane_dir", ((int)((P1 *)_this)->_7_2_lane_dir));
#endif
		;
S_249_0: /* 2 */
		((P1 *)_this)->_7_2_dest_node = 0;
#ifdef VAR_RANGES
		logval("VehicleFSM:dest_node", ((int)((P1 *)_this)->_7_2_dest_node));
#endif
		;
S_250_0: /* 2 */
		((P1 *)_this)->_7_2_incoming = 0;
#ifdef VAR_RANGES
		logval("VehicleFSM:incoming", ((int)((P1 *)_this)->_7_2_incoming));
#endif
		;
S_251_0: /* 2 */
		((P1 *)_this)->_7_2_in_heading = 0;
#ifdef VAR_RANGES
		logval("VehicleFSM:in_heading", ((int)((P1 *)_this)->_7_2_in_heading));
#endif
		;
S_252_0: /* 2 */
		((P1 *)_this)->_7_2_last_sl = 0;
#ifdef VAR_RANGES
		logval("VehicleFSM:last_sl", ((int)((P1 *)_this)->_7_2_last_sl));
#endif
		;
S_253_0: /* 2 */
		((P1 *)_this)->_7_2_nh = 0;
#ifdef VAR_RANGES
		logval("VehicleFSM:nh", ((int)((P1 *)_this)->_7_2_nh));
#endif
		;
S_591_0: /* 2 */
S_254_0: /* 2 */
		if (!(((int)now.moved_this_step[ Index(((int)((P1 *)_this)->vid), 2) ])))
			goto S_591_1;
S_255_0: /* 2 */
		if (!(1))
			Uerror("block in d_step seq");
		goto S_592_0;
S_591_1: /* 3 */
S_256_0: /* 2 */
		if (!(((int)now.returned_A[ Index(((int)((P1 *)_this)->vid), 2) ])))
			goto S_591_2;
S_257_0: /* 2 */
		if (!(1))
			Uerror("block in d_step seq");
		goto S_592_0;
S_591_2: /* 3 */
S_258_0: /* 2 */
		/* else */;
S_589_0: /* 2 */
S_259_0: /* 2 */
		if (!((((int)now.veh_mode[ Index(((int)((P1 *)_this)->vid), 2) ])==0)))
			goto S_589_1;
S_260_0: /* 2 */
		((P1 *)_this)->_7_2_cur_node = ((int)now.veh_node[ Index(((int)((P1 *)_this)->vid), 2) ]);
#ifdef VAR_RANGES
		logval("VehicleFSM:cur_node", ((int)((P1 *)_this)->_7_2_cur_node));
#endif
		;
S_261_0: /* 2 */
		((P1 *)_this)->_7_2_incoming = ((int)now.veh_heading[ Index(((int)((P1 *)_this)->vid), 2) ]);
#ifdef VAR_RANGES
		logval("VehicleFSM:incoming", ((int)((P1 *)_this)->_7_2_incoming));
#endif
		;
S_262_0: /* 2 */
		((P1 *)_this)->_7_2_inc_idx = 0;
#ifdef VAR_RANGES
		logval("VehicleFSM:inc_idx", ((int)((P1 *)_this)->_7_2_inc_idx));
#endif
		;
S_267_0: /* 2 */
S_263_0: /* 2 */
		if (!((((int)((P1 *)_this)->_7_2_incoming)==255)))
			goto S_267_1;
S_264_0: /* 2 */
		((P1 *)_this)->_7_2_inc_idx = 4;
#ifdef VAR_RANGES
		logval("VehicleFSM:inc_idx", ((int)((P1 *)_this)->_7_2_inc_idx));
#endif
		;
		goto S_268_0;
S_267_1: /* 3 */
S_265_0: /* 2 */
		/* else */;
S_266_0: /* 2 */
		((P1 *)_this)->_7_2_inc_idx = ((int)((P1 *)_this)->_7_2_incoming);
#ifdef VAR_RANGES
		logval("VehicleFSM:inc_idx", ((int)((P1 *)_this)->_7_2_inc_idx));
#endif
		;
		goto S_268_0;
S_267_2: /* 3 */
		Uerror("blocking sel in d_step (nr.12, near line 584)");
S_268_0: /* 2 */
S_269_0: /* 2 */
		((P1 *)_this)->_7_2_nh = ((int)now.next_hop_ha[ Index((((((int)((P1 *)_this)->_7_2_cur_node)*50)+(((int)((P1 *)_this)->_7_2_inc_idx)*10))+((int)now.veh_dest[ Index(((int)((P1 *)_this)->vid), 2) ])), 500) ]);
#ifdef VAR_RANGES
		logval("VehicleFSM:nh", ((int)((P1 *)_this)->_7_2_nh));
#endif
		;
S_437_0: /* 2 */
S_270_0: /* 2 */
		if (!((((int)((P1 *)_this)->_7_2_cur_node)==9)))
			goto S_437_1;
S_284_0: /* 2 */
S_271_0: /* 2 */
		if (!((((((int)((P1 *)_this)->_7_2_nh)==0)&& !(((int)now.node_occupied[0])))&&(((int)now.road_slots[ Index((((12*(2*3))+(1*3))+0), 78) ])==0))))
			goto S_284_1;
S_272_0: /* 2 */
		now.road_slots[ Index((((12*(2*3))+(1*3))+0), 78) ] = (((int)((P1 *)_this)->vid)+1);
#ifdef VAR_RANGES
		logval("road_slots[(((12*(2*3))+(1*3))+0)]", ((int)now.road_slots[ Index((((12*(2*3))+(1*3))+0), 78) ]));
#endif
		;
S_273_0: /* 2 */
		now.veh_mode[ Index(((P1 *)_this)->vid, 2) ] = 1;
#ifdef VAR_RANGES
		logval("veh_mode[VehicleFSM:vid]", ((int)now.veh_mode[ Index(((int)((P1 *)_this)->vid), 2) ]));
#endif
		;
S_274_0: /* 2 */
		now.veh_road[ Index(((P1 *)_this)->vid, 2) ] = 12;
#ifdef VAR_RANGES
		logval("veh_road[VehicleFSM:vid]", ((int)now.veh_road[ Index(((int)((P1 *)_this)->vid), 2) ]));
#endif
		;
S_275_0: /* 2 */
		now.veh_dir[ Index(((P1 *)_this)->vid, 2) ] = 1;
#ifdef VAR_RANGES
		logval("veh_dir[VehicleFSM:vid]", ((int)now.veh_dir[ Index(((int)((P1 *)_this)->vid), 2) ]));
#endif
		;
S_276_0: /* 2 */
		now.veh_slot[ Index(((P1 *)_this)->vid, 2) ] = 0;
#ifdef VAR_RANGES
		logval("veh_slot[VehicleFSM:vid]", ((int)now.veh_slot[ Index(((int)((P1 *)_this)->vid), 2) ]));
#endif
		;
S_277_0: /* 2 */
		now.veh_heading[ Index(((P1 *)_this)->vid, 2) ] = 255;
#ifdef VAR_RANGES
		logval("veh_heading[VehicleFSM:vid]", ((int)now.veh_heading[ Index(((int)((P1 *)_this)->vid), 2) ]));
#endif
		;
S_278_0: /* 2 */
		now.node_occupied[9] = 1;
#ifdef VAR_RANGES
		logval("node_occupied[9]", ((int)now.node_occupied[9]));
#endif
		;
S_279_0: /* 2 */
		now.crossing_count[9] = (((int)now.crossing_count[9])+1);
#ifdef VAR_RANGES
		logval("crossing_count[9]", ((int)now.crossing_count[9]));
#endif
		;
S_280_0: /* 2 */
		now.moved_this_step[ Index(((P1 *)_this)->vid, 2) ] = 1;
#ifdef VAR_RANGES
		logval("moved_this_step[VehicleFSM:vid]", ((int)now.moved_this_step[ Index(((int)((P1 *)_this)->vid), 2) ]));
#endif
		;
S_281_0: /* 2 */
		now.sq_a_forbidden[ Index(((P1 *)_this)->vid, 2) ] = 3;
#ifdef VAR_RANGES
		logval("sq_a_forbidden[VehicleFSM:vid]", ((int)now.sq_a_forbidden[ Index(((int)((P1 *)_this)->vid), 2) ]));
#endif
		;
		goto S_285_0;
S_284_1: /* 3 */
S_282_0: /* 2 */
		/* else */;
S_283_0: /* 2 */
		if (!(1))
			Uerror("block in d_step seq");
		goto S_285_0;
S_284_2: /* 3 */
		Uerror("blocking sel in d_step (nr.13, near line 593)");
S_285_0: /* 2 */
		goto S_438_0;
S_437_1: /* 3 */
S_286_0: /* 2 */
		/* else */;
S_287_0: /* 2 */
		((P1 *)_this)->_7_2_out_dir = 255;
#ifdef VAR_RANGES
		logval("VehicleFSM:out_dir", ((int)((P1 *)_this)->_7_2_out_dir));
#endif
		;
S_288_0: /* 2 */
		((P1 *)_this)->_7_2_road_id = 255;
#ifdef VAR_RANGES
		logval("VehicleFSM:road_id", ((int)((P1 *)_this)->_7_2_road_id));
#endif
		;
S_289_0: /* 2 */
		((P1 *)_this)->_7_2_lane_dir = 0;
#ifdef VAR_RANGES
		logval("VehicleFSM:lane_dir", ((int)((P1 *)_this)->_7_2_lane_dir));
#endif
		;
S_392_0: /* 2 */
S_290_0: /* 2 */
		if (!(((((int)((P1 *)_this)->_7_2_cur_node)==0)&&(((int)((P1 *)_this)->_7_2_nh)==1))))
			goto S_392_1;
S_291_0: /* 2 */
		((P1 *)_this)->_7_2_out_dir = 1;
#ifdef VAR_RANGES
		logval("VehicleFSM:out_dir", ((int)((P1 *)_this)->_7_2_out_dir));
#endif
		;
S_292_0: /* 2 */
		((P1 *)_this)->_7_2_road_id = 0;
#ifdef VAR_RANGES
		logval("VehicleFSM:road_id", ((int)((P1 *)_this)->_7_2_road_id));
#endif
		;
S_293_0: /* 2 */
		((P1 *)_this)->_7_2_lane_dir = 0;
#ifdef VAR_RANGES
		logval("VehicleFSM:lane_dir", ((int)((P1 *)_this)->_7_2_lane_dir));
#endif
		;
		goto S_393_0;
S_392_1: /* 3 */
S_294_0: /* 2 */
		if (!(((((int)((P1 *)_this)->_7_2_cur_node)==0)&&(((int)((P1 *)_this)->_7_2_nh)==3))))
			goto S_392_2;
S_295_0: /* 2 */
		((P1 *)_this)->_7_2_out_dir = 2;
#ifdef VAR_RANGES
		logval("VehicleFSM:out_dir", ((int)((P1 *)_this)->_7_2_out_dir));
#endif
		;
S_296_0: /* 2 */
		((P1 *)_this)->_7_2_road_id = 6;
#ifdef VAR_RANGES
		logval("VehicleFSM:road_id", ((int)((P1 *)_this)->_7_2_road_id));
#endif
		;
S_297_0: /* 2 */
		((P1 *)_this)->_7_2_lane_dir = 0;
#ifdef VAR_RANGES
		logval("VehicleFSM:lane_dir", ((int)((P1 *)_this)->_7_2_lane_dir));
#endif
		;
		goto S_393_0;
S_392_2: /* 3 */
S_298_0: /* 2 */
		if (!(((((int)((P1 *)_this)->_7_2_cur_node)==0)&&(((int)((P1 *)_this)->_7_2_nh)==9))))
			goto S_392_3;
S_299_0: /* 2 */
		((P1 *)_this)->_7_2_out_dir = 3;
#ifdef VAR_RANGES
		logval("VehicleFSM:out_dir", ((int)((P1 *)_this)->_7_2_out_dir));
#endif
		;
S_300_0: /* 2 */
		((P1 *)_this)->_7_2_road_id = 12;
#ifdef VAR_RANGES
		logval("VehicleFSM:road_id", ((int)((P1 *)_this)->_7_2_road_id));
#endif
		;
S_301_0: /* 2 */
		((P1 *)_this)->_7_2_lane_dir = 0;
#ifdef VAR_RANGES
		logval("VehicleFSM:lane_dir", ((int)((P1 *)_this)->_7_2_lane_dir));
#endif
		;
		goto S_393_0;
S_392_3: /* 3 */
S_302_0: /* 2 */
		if (!(((((int)((P1 *)_this)->_7_2_cur_node)==1)&&(((int)((P1 *)_this)->_7_2_nh)==2))))
			goto S_392_4;
S_303_0: /* 2 */
		((P1 *)_this)->_7_2_out_dir = 1;
#ifdef VAR_RANGES
		logval("VehicleFSM:out_dir", ((int)((P1 *)_this)->_7_2_out_dir));
#endif
		;
S_304_0: /* 2 */
		((P1 *)_this)->_7_2_road_id = 1;
#ifdef VAR_RANGES
		logval("VehicleFSM:road_id", ((int)((P1 *)_this)->_7_2_road_id));
#endif
		;
S_305_0: /* 2 */
		((P1 *)_this)->_7_2_lane_dir = 0;
#ifdef VAR_RANGES
		logval("VehicleFSM:lane_dir", ((int)((P1 *)_this)->_7_2_lane_dir));
#endif
		;
		goto S_393_0;
S_392_4: /* 3 */
S_306_0: /* 2 */
		if (!(((((int)((P1 *)_this)->_7_2_cur_node)==1)&&(((int)((P1 *)_this)->_7_2_nh)==4))))
			goto S_392_5;
S_307_0: /* 2 */
		((P1 *)_this)->_7_2_out_dir = 2;
#ifdef VAR_RANGES
		logval("VehicleFSM:out_dir", ((int)((P1 *)_this)->_7_2_out_dir));
#endif
		;
S_308_0: /* 2 */
		((P1 *)_this)->_7_2_road_id = 7;
#ifdef VAR_RANGES
		logval("VehicleFSM:road_id", ((int)((P1 *)_this)->_7_2_road_id));
#endif
		;
S_309_0: /* 2 */
		((P1 *)_this)->_7_2_lane_dir = 0;
#ifdef VAR_RANGES
		logval("VehicleFSM:lane_dir", ((int)((P1 *)_this)->_7_2_lane_dir));
#endif
		;
		goto S_393_0;
S_392_5: /* 3 */
S_310_0: /* 2 */
		if (!(((((int)((P1 *)_this)->_7_2_cur_node)==1)&&(((int)((P1 *)_this)->_7_2_nh)==0))))
			goto S_392_6;
S_311_0: /* 2 */
		((P1 *)_this)->_7_2_out_dir = 3;
#ifdef VAR_RANGES
		logval("VehicleFSM:out_dir", ((int)((P1 *)_this)->_7_2_out_dir));
#endif
		;
S_312_0: /* 2 */
		((P1 *)_this)->_7_2_road_id = 0;
#ifdef VAR_RANGES
		logval("VehicleFSM:road_id", ((int)((P1 *)_this)->_7_2_road_id));
#endif
		;
S_313_0: /* 2 */
		((P1 *)_this)->_7_2_lane_dir = 1;
#ifdef VAR_RANGES
		logval("VehicleFSM:lane_dir", ((int)((P1 *)_this)->_7_2_lane_dir));
#endif
		;
		goto S_393_0;
S_392_6: /* 3 */
S_314_0: /* 2 */
		if (!(((((int)((P1 *)_this)->_7_2_cur_node)==2)&&(((int)((P1 *)_this)->_7_2_nh)==5))))
			goto S_392_7;
S_315_0: /* 2 */
		((P1 *)_this)->_7_2_out_dir = 2;
#ifdef VAR_RANGES
		logval("VehicleFSM:out_dir", ((int)((P1 *)_this)->_7_2_out_dir));
#endif
		;
S_316_0: /* 2 */
		((P1 *)_this)->_7_2_road_id = 8;
#ifdef VAR_RANGES
		logval("VehicleFSM:road_id", ((int)((P1 *)_this)->_7_2_road_id));
#endif
		;
S_317_0: /* 2 */
		((P1 *)_this)->_7_2_lane_dir = 0;
#ifdef VAR_RANGES
		logval("VehicleFSM:lane_dir", ((int)((P1 *)_this)->_7_2_lane_dir));
#endif
		;
		goto S_393_0;
S_392_7: /* 3 */
S_318_0: /* 2 */
		if (!(((((int)((P1 *)_this)->_7_2_cur_node)==2)&&(((int)((P1 *)_this)->_7_2_nh)==1))))
			goto S_392_8;
S_319_0: /* 2 */
		((P1 *)_this)->_7_2_out_dir = 3;
#ifdef VAR_RANGES
		logval("VehicleFSM:out_dir", ((int)((P1 *)_this)->_7_2_out_dir));
#endif
		;
S_320_0: /* 2 */
		((P1 *)_this)->_7_2_road_id = 1;
#ifdef VAR_RANGES
		logval("VehicleFSM:road_id", ((int)((P1 *)_this)->_7_2_road_id));
#endif
		;
S_321_0: /* 2 */
		((P1 *)_this)->_7_2_lane_dir = 1;
#ifdef VAR_RANGES
		logval("VehicleFSM:lane_dir", ((int)((P1 *)_this)->_7_2_lane_dir));
#endif
		;
		goto S_393_0;
S_392_8: /* 3 */
S_322_0: /* 2 */
		if (!(((((int)((P1 *)_this)->_7_2_cur_node)==3)&&(((int)((P1 *)_this)->_7_2_nh)==0))))
			goto S_392_9;
S_323_0: /* 2 */
		((P1 *)_this)->_7_2_out_dir = 0;
#ifdef VAR_RANGES
		logval("VehicleFSM:out_dir", ((int)((P1 *)_this)->_7_2_out_dir));
#endif
		;
S_324_0: /* 2 */
		((P1 *)_this)->_7_2_road_id = 6;
#ifdef VAR_RANGES
		logval("VehicleFSM:road_id", ((int)((P1 *)_this)->_7_2_road_id));
#endif
		;
S_325_0: /* 2 */
		((P1 *)_this)->_7_2_lane_dir = 1;
#ifdef VAR_RANGES
		logval("VehicleFSM:lane_dir", ((int)((P1 *)_this)->_7_2_lane_dir));
#endif
		;
		goto S_393_0;
S_392_9: /* 3 */
S_326_0: /* 2 */
		if (!(((((int)((P1 *)_this)->_7_2_cur_node)==3)&&(((int)((P1 *)_this)->_7_2_nh)==4))))
			goto S_392_10;
S_327_0: /* 2 */
		((P1 *)_this)->_7_2_out_dir = 1;
#ifdef VAR_RANGES
		logval("VehicleFSM:out_dir", ((int)((P1 *)_this)->_7_2_out_dir));
#endif
		;
S_328_0: /* 2 */
		((P1 *)_this)->_7_2_road_id = 2;
#ifdef VAR_RANGES
		logval("VehicleFSM:road_id", ((int)((P1 *)_this)->_7_2_road_id));
#endif
		;
S_329_0: /* 2 */
		((P1 *)_this)->_7_2_lane_dir = 0;
#ifdef VAR_RANGES
		logval("VehicleFSM:lane_dir", ((int)((P1 *)_this)->_7_2_lane_dir));
#endif
		;
		goto S_393_0;
S_392_10: /* 3 */
S_330_0: /* 2 */
		if (!(((((int)((P1 *)_this)->_7_2_cur_node)==3)&&(((int)((P1 *)_this)->_7_2_nh)==6))))
			goto S_392_11;
S_331_0: /* 2 */
		((P1 *)_this)->_7_2_out_dir = 2;
#ifdef VAR_RANGES
		logval("VehicleFSM:out_dir", ((int)((P1 *)_this)->_7_2_out_dir));
#endif
		;
S_332_0: /* 2 */
		((P1 *)_this)->_7_2_road_id = 9;
#ifdef VAR_RANGES
		logval("VehicleFSM:road_id", ((int)((P1 *)_this)->_7_2_road_id));
#endif
		;
S_333_0: /* 2 */
		((P1 *)_this)->_7_2_lane_dir = 0;
#ifdef VAR_RANGES
		logval("VehicleFSM:lane_dir", ((int)((P1 *)_this)->_7_2_lane_dir));
#endif
		;
		goto S_393_0;
S_392_11: /* 3 */
S_334_0: /* 2 */
		if (!(((((int)((P1 *)_this)->_7_2_cur_node)==4)&&(((int)((P1 *)_this)->_7_2_nh)==1))))
			goto S_392_12;
S_335_0: /* 2 */
		((P1 *)_this)->_7_2_out_dir = 0;
#ifdef VAR_RANGES
		logval("VehicleFSM:out_dir", ((int)((P1 *)_this)->_7_2_out_dir));
#endif
		;
S_336_0: /* 2 */
		((P1 *)_this)->_7_2_road_id = 7;
#ifdef VAR_RANGES
		logval("VehicleFSM:road_id", ((int)((P1 *)_this)->_7_2_road_id));
#endif
		;
S_337_0: /* 2 */
		((P1 *)_this)->_7_2_lane_dir = 1;
#ifdef VAR_RANGES
		logval("VehicleFSM:lane_dir", ((int)((P1 *)_this)->_7_2_lane_dir));
#endif
		;
		goto S_393_0;
S_392_12: /* 3 */
S_338_0: /* 2 */
		if (!(((((int)((P1 *)_this)->_7_2_cur_node)==4)&&(((int)((P1 *)_this)->_7_2_nh)==5))))
			goto S_392_13;
S_339_0: /* 2 */
		((P1 *)_this)->_7_2_out_dir = 1;
#ifdef VAR_RANGES
		logval("VehicleFSM:out_dir", ((int)((P1 *)_this)->_7_2_out_dir));
#endif
		;
S_340_0: /* 2 */
		((P1 *)_this)->_7_2_road_id = 3;
#ifdef VAR_RANGES
		logval("VehicleFSM:road_id", ((int)((P1 *)_this)->_7_2_road_id));
#endif
		;
S_341_0: /* 2 */
		((P1 *)_this)->_7_2_lane_dir = 0;
#ifdef VAR_RANGES
		logval("VehicleFSM:lane_dir", ((int)((P1 *)_this)->_7_2_lane_dir));
#endif
		;
		goto S_393_0;
S_392_13: /* 3 */
S_342_0: /* 2 */
		if (!(((((int)((P1 *)_this)->_7_2_cur_node)==4)&&(((int)((P1 *)_this)->_7_2_nh)==7))))
			goto S_392_14;
S_343_0: /* 2 */
		((P1 *)_this)->_7_2_out_dir = 2;
#ifdef VAR_RANGES
		logval("VehicleFSM:out_dir", ((int)((P1 *)_this)->_7_2_out_dir));
#endif
		;
S_344_0: /* 2 */
		((P1 *)_this)->_7_2_road_id = 10;
#ifdef VAR_RANGES
		logval("VehicleFSM:road_id", ((int)((P1 *)_this)->_7_2_road_id));
#endif
		;
S_345_0: /* 2 */
		((P1 *)_this)->_7_2_lane_dir = 0;
#ifdef VAR_RANGES
		logval("VehicleFSM:lane_dir", ((int)((P1 *)_this)->_7_2_lane_dir));
#endif
		;
		goto S_393_0;
S_392_14: /* 3 */
S_346_0: /* 2 */
		if (!(((((int)((P1 *)_this)->_7_2_cur_node)==4)&&(((int)((P1 *)_this)->_7_2_nh)==3))))
			goto S_392_15;
S_347_0: /* 2 */
		((P1 *)_this)->_7_2_out_dir = 3;
#ifdef VAR_RANGES
		logval("VehicleFSM:out_dir", ((int)((P1 *)_this)->_7_2_out_dir));
#endif
		;
S_348_0: /* 2 */
		((P1 *)_this)->_7_2_road_id = 2;
#ifdef VAR_RANGES
		logval("VehicleFSM:road_id", ((int)((P1 *)_this)->_7_2_road_id));
#endif
		;
S_349_0: /* 2 */
		((P1 *)_this)->_7_2_lane_dir = 1;
#ifdef VAR_RANGES
		logval("VehicleFSM:lane_dir", ((int)((P1 *)_this)->_7_2_lane_dir));
#endif
		;
		goto S_393_0;
S_392_15: /* 3 */
S_350_0: /* 2 */
		if (!(((((int)((P1 *)_this)->_7_2_cur_node)==5)&&(((int)((P1 *)_this)->_7_2_nh)==2))))
			goto S_392_16;
S_351_0: /* 2 */
		((P1 *)_this)->_7_2_out_dir = 0;
#ifdef VAR_RANGES
		logval("VehicleFSM:out_dir", ((int)((P1 *)_this)->_7_2_out_dir));
#endif
		;
S_352_0: /* 2 */
		((P1 *)_this)->_7_2_road_id = 8;
#ifdef VAR_RANGES
		logval("VehicleFSM:road_id", ((int)((P1 *)_this)->_7_2_road_id));
#endif
		;
S_353_0: /* 2 */
		((P1 *)_this)->_7_2_lane_dir = 1;
#ifdef VAR_RANGES
		logval("VehicleFSM:lane_dir", ((int)((P1 *)_this)->_7_2_lane_dir));
#endif
		;
		goto S_393_0;
S_392_16: /* 3 */
S_354_0: /* 2 */
		if (!(((((int)((P1 *)_this)->_7_2_cur_node)==5)&&(((int)((P1 *)_this)->_7_2_nh)==8))))
			goto S_392_17;
S_355_0: /* 2 */
		((P1 *)_this)->_7_2_out_dir = 2;
#ifdef VAR_RANGES
		logval("VehicleFSM:out_dir", ((int)((P1 *)_this)->_7_2_out_dir));
#endif
		;
S_356_0: /* 2 */
		((P1 *)_this)->_7_2_road_id = 11;
#ifdef VAR_RANGES
		logval("VehicleFSM:road_id", ((int)((P1 *)_this)->_7_2_road_id));
#endif
		;
S_357_0: /* 2 */
		((P1 *)_this)->_7_2_lane_dir = 0;
#ifdef VAR_RANGES
		logval("VehicleFSM:lane_dir", ((int)((P1 *)_this)->_7_2_lane_dir));
#endif
		;
		goto S_393_0;
S_392_17: /* 3 */
S_358_0: /* 2 */
		if (!(((((int)((P1 *)_this)->_7_2_cur_node)==5)&&(((int)((P1 *)_this)->_7_2_nh)==4))))
			goto S_392_18;
S_359_0: /* 2 */
		((P1 *)_this)->_7_2_out_dir = 3;
#ifdef VAR_RANGES
		logval("VehicleFSM:out_dir", ((int)((P1 *)_this)->_7_2_out_dir));
#endif
		;
S_360_0: /* 2 */
		((P1 *)_this)->_7_2_road_id = 3;
#ifdef VAR_RANGES
		logval("VehicleFSM:road_id", ((int)((P1 *)_this)->_7_2_road_id));
#endif
		;
S_361_0: /* 2 */
		((P1 *)_this)->_7_2_lane_dir = 1;
#ifdef VAR_RANGES
		logval("VehicleFSM:lane_dir", ((int)((P1 *)_this)->_7_2_lane_dir));
#endif
		;
		goto S_393_0;
S_392_18: /* 3 */
S_362_0: /* 2 */
		if (!(((((int)((P1 *)_this)->_7_2_cur_node)==6)&&(((int)((P1 *)_this)->_7_2_nh)==3))))
			goto S_392_19;
S_363_0: /* 2 */
		((P1 *)_this)->_7_2_out_dir = 0;
#ifdef VAR_RANGES
		logval("VehicleFSM:out_dir", ((int)((P1 *)_this)->_7_2_out_dir));
#endif
		;
S_364_0: /* 2 */
		((P1 *)_this)->_7_2_road_id = 9;
#ifdef VAR_RANGES
		logval("VehicleFSM:road_id", ((int)((P1 *)_this)->_7_2_road_id));
#endif
		;
S_365_0: /* 2 */
		((P1 *)_this)->_7_2_lane_dir = 1;
#ifdef VAR_RANGES
		logval("VehicleFSM:lane_dir", ((int)((P1 *)_this)->_7_2_lane_dir));
#endif
		;
		goto S_393_0;
S_392_19: /* 3 */
S_366_0: /* 2 */
		if (!(((((int)((P1 *)_this)->_7_2_cur_node)==6)&&(((int)((P1 *)_this)->_7_2_nh)==7))))
			goto S_392_20;
S_367_0: /* 2 */
		((P1 *)_this)->_7_2_out_dir = 1;
#ifdef VAR_RANGES
		logval("VehicleFSM:out_dir", ((int)((P1 *)_this)->_7_2_out_dir));
#endif
		;
S_368_0: /* 2 */
		((P1 *)_this)->_7_2_road_id = 4;
#ifdef VAR_RANGES
		logval("VehicleFSM:road_id", ((int)((P1 *)_this)->_7_2_road_id));
#endif
		;
S_369_0: /* 2 */
		((P1 *)_this)->_7_2_lane_dir = 0;
#ifdef VAR_RANGES
		logval("VehicleFSM:lane_dir", ((int)((P1 *)_this)->_7_2_lane_dir));
#endif
		;
		goto S_393_0;
S_392_20: /* 3 */
S_370_0: /* 2 */
		if (!(((((int)((P1 *)_this)->_7_2_cur_node)==7)&&(((int)((P1 *)_this)->_7_2_nh)==4))))
			goto S_392_21;
S_371_0: /* 2 */
		((P1 *)_this)->_7_2_out_dir = 0;
#ifdef VAR_RANGES
		logval("VehicleFSM:out_dir", ((int)((P1 *)_this)->_7_2_out_dir));
#endif
		;
S_372_0: /* 2 */
		((P1 *)_this)->_7_2_road_id = 10;
#ifdef VAR_RANGES
		logval("VehicleFSM:road_id", ((int)((P1 *)_this)->_7_2_road_id));
#endif
		;
S_373_0: /* 2 */
		((P1 *)_this)->_7_2_lane_dir = 1;
#ifdef VAR_RANGES
		logval("VehicleFSM:lane_dir", ((int)((P1 *)_this)->_7_2_lane_dir));
#endif
		;
		goto S_393_0;
S_392_21: /* 3 */
S_374_0: /* 2 */
		if (!(((((int)((P1 *)_this)->_7_2_cur_node)==7)&&(((int)((P1 *)_this)->_7_2_nh)==8))))
			goto S_392_22;
S_375_0: /* 2 */
		((P1 *)_this)->_7_2_out_dir = 1;
#ifdef VAR_RANGES
		logval("VehicleFSM:out_dir", ((int)((P1 *)_this)->_7_2_out_dir));
#endif
		;
S_376_0: /* 2 */
		((P1 *)_this)->_7_2_road_id = 5;
#ifdef VAR_RANGES
		logval("VehicleFSM:road_id", ((int)((P1 *)_this)->_7_2_road_id));
#endif
		;
S_377_0: /* 2 */
		((P1 *)_this)->_7_2_lane_dir = 0;
#ifdef VAR_RANGES
		logval("VehicleFSM:lane_dir", ((int)((P1 *)_this)->_7_2_lane_dir));
#endif
		;
		goto S_393_0;
S_392_22: /* 3 */
S_378_0: /* 2 */
		if (!(((((int)((P1 *)_this)->_7_2_cur_node)==7)&&(((int)((P1 *)_this)->_7_2_nh)==6))))
			goto S_392_23;
S_379_0: /* 2 */
		((P1 *)_this)->_7_2_out_dir = 3;
#ifdef VAR_RANGES
		logval("VehicleFSM:out_dir", ((int)((P1 *)_this)->_7_2_out_dir));
#endif
		;
S_380_0: /* 2 */
		((P1 *)_this)->_7_2_road_id = 4;
#ifdef VAR_RANGES
		logval("VehicleFSM:road_id", ((int)((P1 *)_this)->_7_2_road_id));
#endif
		;
S_381_0: /* 2 */
		((P1 *)_this)->_7_2_lane_dir = 1;
#ifdef VAR_RANGES
		logval("VehicleFSM:lane_dir", ((int)((P1 *)_this)->_7_2_lane_dir));
#endif
		;
		goto S_393_0;
S_392_23: /* 3 */
S_382_0: /* 2 */
		if (!(((((int)((P1 *)_this)->_7_2_cur_node)==8)&&(((int)((P1 *)_this)->_7_2_nh)==5))))
			goto S_392_24;
S_383_0: /* 2 */
		((P1 *)_this)->_7_2_out_dir = 0;
#ifdef VAR_RANGES
		logval("VehicleFSM:out_dir", ((int)((P1 *)_this)->_7_2_out_dir));
#endif
		;
S_384_0: /* 2 */
		((P1 *)_this)->_7_2_road_id = 11;
#ifdef VAR_RANGES
		logval("VehicleFSM:road_id", ((int)((P1 *)_this)->_7_2_road_id));
#endif
		;
S_385_0: /* 2 */
		((P1 *)_this)->_7_2_lane_dir = 1;
#ifdef VAR_RANGES
		logval("VehicleFSM:lane_dir", ((int)((P1 *)_this)->_7_2_lane_dir));
#endif
		;
		goto S_393_0;
S_392_24: /* 3 */
S_386_0: /* 2 */
		if (!(((((int)((P1 *)_this)->_7_2_cur_node)==8)&&(((int)((P1 *)_this)->_7_2_nh)==7))))
			goto S_392_25;
S_387_0: /* 2 */
		((P1 *)_this)->_7_2_out_dir = 3;
#ifdef VAR_RANGES
		logval("VehicleFSM:out_dir", ((int)((P1 *)_this)->_7_2_out_dir));
#endif
		;
S_388_0: /* 2 */
		((P1 *)_this)->_7_2_road_id = 5;
#ifdef VAR_RANGES
		logval("VehicleFSM:road_id", ((int)((P1 *)_this)->_7_2_road_id));
#endif
		;
S_389_0: /* 2 */
		((P1 *)_this)->_7_2_lane_dir = 1;
#ifdef VAR_RANGES
		logval("VehicleFSM:lane_dir", ((int)((P1 *)_this)->_7_2_lane_dir));
#endif
		;
		goto S_393_0;
S_392_25: /* 3 */
S_390_0: /* 2 */
		/* else */;
S_391_0: /* 2 */
		((P1 *)_this)->_7_2_out_dir = 255;
#ifdef VAR_RANGES
		logval("VehicleFSM:out_dir", ((int)((P1 *)_this)->_7_2_out_dir));
#endif
		;
		goto S_393_0;
S_392_26: /* 3 */
		Uerror("blocking sel in d_step (nr.14, near line 618)");
S_393_0: /* 2 */
S_435_0: /* 2 */
S_394_0: /* 2 */
		if (!((((int)((P1 *)_this)->_7_2_out_dir)==255)))
			goto S_435_1;
S_395_0: /* 2 */
		if (!(1))
			Uerror("block in d_step seq");
		goto S_436_0;
S_435_1: /* 3 */
S_396_0: /* 2 */
		/* else */;
S_397_0: /* 2 */
		((P1 *)_this)->_7_2_is_uturn = 0;
#ifdef VAR_RANGES
		logval("VehicleFSM:is_uturn", ((int)((P1 *)_this)->_7_2_is_uturn));
#endif
		;
S_403_0: /* 2 */
S_398_0: /* 2 */
		if (!(((((int)((P1 *)_this)->_7_2_incoming)!=255)&&(((int)((P1 *)_this)->_7_2_out_dir)==((int)((P1 *)_this)->_7_2_incoming)))))
			goto S_403_1;
S_399_0: /* 2 */
		((P1 *)_this)->_7_2_is_uturn = 1;
#ifdef VAR_RANGES
		logval("VehicleFSM:is_uturn", ((int)((P1 *)_this)->_7_2_is_uturn));
#endif
		;
S_400_0: /* 2 */
		now.uturn_violation = 1;
#ifdef VAR_RANGES
		logval("uturn_violation", ((int)now.uturn_violation));
#endif
		;
		goto S_404_0;
S_403_1: /* 3 */
S_401_0: /* 2 */
		/* else */;
S_402_0: /* 2 */
		if (!(1))
			Uerror("block in d_step seq");
		goto S_404_0;
S_403_2: /* 3 */
		Uerror("blocking sel in d_step (nr.15, near line 663)");
S_404_0: /* 2 */
S_405_0: /* 2 */
		((P1 *)_this)->_7_2_is_forbidden = 0;
#ifdef VAR_RANGES
		logval("VehicleFSM:is_forbidden", ((int)((P1 *)_this)->_7_2_is_forbidden));
#endif
		;
S_410_0: /* 2 */
S_406_0: /* 2 */
		if (!(((((int)now.sq_a_forbidden[ Index(((int)((P1 *)_this)->vid), 2) ])!=255)&&(((int)((P1 *)_this)->_7_2_out_dir)==((int)now.sq_a_forbidden[ Index(((int)((P1 *)_this)->vid), 2) ])))))
			goto S_410_1;
S_407_0: /* 2 */
		((P1 *)_this)->_7_2_is_forbidden = 1;
#ifdef VAR_RANGES
		logval("VehicleFSM:is_forbidden", ((int)((P1 *)_this)->_7_2_is_forbidden));
#endif
		;
		goto S_411_0;
S_410_1: /* 3 */
S_408_0: /* 2 */
		/* else */;
S_409_0: /* 2 */
		if (!(1))
			Uerror("block in d_step seq");
		goto S_411_0;
S_410_2: /* 3 */
		Uerror("blocking sel in d_step (nr.16, near line 671)");
S_411_0: /* 2 */
S_433_0: /* 2 */
S_412_0: /* 2 */
		if (!(((int)((P1 *)_this)->_7_2_is_uturn)))
			goto S_433_1;
S_413_0: /* 2 */
		if (!(1))
			Uerror("block in d_step seq");
		goto S_434_0;
S_433_1: /* 3 */
S_414_0: /* 2 */
		if (!(((int)((P1 *)_this)->_7_2_is_forbidden)))
			goto S_433_2;
S_415_0: /* 2 */
		if (!(1))
			Uerror("block in d_step seq");
		goto S_434_0;
S_433_2: /* 3 */
S_416_0: /* 2 */
		if (!((( !(((int)((P1 *)_this)->_7_2_is_uturn))&& !(((int)((P1 *)_this)->_7_2_is_forbidden)))&&(((int)now.light_green[ Index(((int)((P1 *)_this)->_7_2_cur_node), 10) ])!=((int)((P1 *)_this)->_7_2_out_dir)))))
			goto S_433_3;
S_417_0: /* 2 */
		if (!(1))
			Uerror("block in d_step seq");
		goto S_434_0;
S_433_3: /* 3 */
S_418_0: /* 2 */
		if (!(((( !(((int)((P1 *)_this)->_7_2_is_uturn))&& !(((int)((P1 *)_this)->_7_2_is_forbidden)))&&(((int)now.light_green[ Index(((int)((P1 *)_this)->_7_2_cur_node), 10) ])==((int)((P1 *)_this)->_7_2_out_dir)))&&((int)now.node_occupied[ Index(((int)((P1 *)_this)->_7_2_cur_node), 10) ]))))
			goto S_433_4;
S_419_0: /* 2 */
		if (!(1))
			Uerror("block in d_step seq");
		goto S_434_0;
S_433_4: /* 3 */
S_420_0: /* 2 */
		if (!((((( !(((int)((P1 *)_this)->_7_2_is_uturn))&& !(((int)((P1 *)_this)->_7_2_is_forbidden)))&&(((int)now.light_green[ Index(((int)((P1 *)_this)->_7_2_cur_node), 10) ])==((int)((P1 *)_this)->_7_2_out_dir)))&& !(((int)now.node_occupied[ Index(((int)((P1 *)_this)->_7_2_cur_node), 10) ])))&&(((int)now.road_slots[ Index((((((int)((P1 *)_this)->_7_2_road_id)*(2*3))+(((int)((P1 *)_this)->_7_2_lane_dir)*3))+0), 78) ])!=0))))
			goto S_433_5;
S_421_0: /* 2 */
		if (!(1))
			Uerror("block in d_step seq");
		goto S_434_0;
S_433_5: /* 3 */
S_422_0: /* 2 */
		if (!((((( !(((int)((P1 *)_this)->_7_2_is_uturn))&& !(((int)((P1 *)_this)->_7_2_is_forbidden)))&&(((int)now.light_green[ Index(((int)((P1 *)_this)->_7_2_cur_node), 10) ])==((int)((P1 *)_this)->_7_2_out_dir)))&& !(((int)now.node_occupied[ Index(((int)((P1 *)_this)->_7_2_cur_node), 10) ])))&&(((int)now.road_slots[ Index((((((int)((P1 *)_this)->_7_2_road_id)*(2*3))+(((int)((P1 *)_this)->_7_2_lane_dir)*3))+0), 78) ])==0))))
			goto S_433_6;
S_423_0: /* 2 */
		now.road_slots[ Index((((((P1 *)_this)->_7_2_road_id*(2*3))+(((P1 *)_this)->_7_2_lane_dir*3))+0), 78) ] = (((int)((P1 *)_this)->vid)+1);
#ifdef VAR_RANGES
		logval("road_slots[(((VehicleFSM:road_id*(2*3))+(VehicleFSM:lane_dir*3))+0)]", ((int)now.road_slots[ Index((((((int)((P1 *)_this)->_7_2_road_id)*(2*3))+(((int)((P1 *)_this)->_7_2_lane_dir)*3))+0), 78) ]));
#endif
		;
S_424_0: /* 2 */
		now.veh_mode[ Index(((P1 *)_this)->vid, 2) ] = 1;
#ifdef VAR_RANGES
		logval("veh_mode[VehicleFSM:vid]", ((int)now.veh_mode[ Index(((int)((P1 *)_this)->vid), 2) ]));
#endif
		;
S_425_0: /* 2 */
		now.veh_road[ Index(((P1 *)_this)->vid, 2) ] = ((int)((P1 *)_this)->_7_2_road_id);
#ifdef VAR_RANGES
		logval("veh_road[VehicleFSM:vid]", ((int)now.veh_road[ Index(((int)((P1 *)_this)->vid), 2) ]));
#endif
		;
S_426_0: /* 2 */
		now.veh_dir[ Index(((P1 *)_this)->vid, 2) ] = ((int)((P1 *)_this)->_7_2_lane_dir);
#ifdef VAR_RANGES
		logval("veh_dir[VehicleFSM:vid]", ((int)now.veh_dir[ Index(((int)((P1 *)_this)->vid), 2) ]));
#endif
		;
S_427_0: /* 2 */
		now.veh_slot[ Index(((P1 *)_this)->vid, 2) ] = 0;
#ifdef VAR_RANGES
		logval("veh_slot[VehicleFSM:vid]", ((int)now.veh_slot[ Index(((int)((P1 *)_this)->vid), 2) ]));
#endif
		;
S_428_0: /* 2 */
		now.veh_heading[ Index(((P1 *)_this)->vid, 2) ] = 255;
#ifdef VAR_RANGES
		logval("veh_heading[VehicleFSM:vid]", ((int)now.veh_heading[ Index(((int)((P1 *)_this)->vid), 2) ]));
#endif
		;
S_429_0: /* 2 */
		now.node_occupied[ Index(((P1 *)_this)->_7_2_cur_node, 10) ] = 1;
#ifdef VAR_RANGES
		logval("node_occupied[VehicleFSM:cur_node]", ((int)now.node_occupied[ Index(((int)((P1 *)_this)->_7_2_cur_node), 10) ]));
#endif
		;
S_430_0: /* 2 */
		now.crossing_count[ Index(((P1 *)_this)->_7_2_cur_node, 10) ] = (((int)now.crossing_count[ Index(((int)((P1 *)_this)->_7_2_cur_node), 10) ])+1);
#ifdef VAR_RANGES
		logval("crossing_count[VehicleFSM:cur_node]", ((int)now.crossing_count[ Index(((int)((P1 *)_this)->_7_2_cur_node), 10) ]));
#endif
		;
S_431_0: /* 2 */
		now.moved_this_step[ Index(((P1 *)_this)->vid, 2) ] = 1;
#ifdef VAR_RANGES
		logval("moved_this_step[VehicleFSM:vid]", ((int)now.moved_this_step[ Index(((int)((P1 *)_this)->vid), 2) ]));
#endif
		;
S_432_0: /* 2 */
		now.sq_a_forbidden[ Index(((P1 *)_this)->vid, 2) ] = 255;
#ifdef VAR_RANGES
		logval("sq_a_forbidden[VehicleFSM:vid]", ((int)now.sq_a_forbidden[ Index(((int)((P1 *)_this)->vid), 2) ]));
#endif
		;
		goto S_434_0;
S_433_6: /* 3 */
		Uerror("blocking sel in d_step (nr.17, near line 677)");
S_434_0: /* 2 */
		goto S_436_0;
S_435_2: /* 3 */
		Uerror("blocking sel in d_step (nr.18, near line 656)");
S_436_0: /* 2 */
		goto S_438_0;
S_437_2: /* 3 */
		Uerror("blocking sel in d_step (nr.19, near line 591)");
S_438_0: /* 2 */
		goto S_590_0;
S_589_1: /* 3 */
S_439_0: /* 2 */
		if (!((((int)now.veh_mode[ Index(((int)((P1 *)_this)->vid), 2) ])==1)))
			goto S_589_2;
S_440_0: /* 2 */
		((P1 *)_this)->_7_2_cur_slot = ((int)now.veh_slot[ Index(((int)((P1 *)_this)->vid), 2) ]);
#ifdef VAR_RANGES
		logval("VehicleFSM:cur_slot", ((int)((P1 *)_this)->_7_2_cur_slot));
#endif
		;
S_445_0: /* 2 */
S_441_0: /* 2 */
		if (!((((int)now.veh_road[ Index(((int)((P1 *)_this)->vid), 2) ])>=12)))
			goto S_445_1;
S_442_0: /* 2 */
		((P1 *)_this)->_7_2_last_sl = 0;
#ifdef VAR_RANGES
		logval("VehicleFSM:last_sl", ((int)((P1 *)_this)->_7_2_last_sl));
#endif
		;
		goto S_446_0;
S_445_1: /* 3 */
S_443_0: /* 2 */
		/* else */;
S_444_0: /* 2 */
		((P1 *)_this)->_7_2_last_sl = (3-1);
#ifdef VAR_RANGES
		logval("VehicleFSM:last_sl", ((int)((P1 *)_this)->_7_2_last_sl));
#endif
		;
		goto S_446_0;
S_445_2: /* 3 */
		Uerror("blocking sel in d_step (nr.20, near line 709)");
S_446_0: /* 2 */
S_585_0: /* 2 */
S_447_0: /* 2 */
		if (!((((int)((P1 *)_this)->_7_2_cur_slot)<((int)((P1 *)_this)->_7_2_last_sl))))
			goto S_585_1;
S_455_0: /* 2 */
S_448_0: /* 2 */
		if (!((((int)now.road_slots[ Index((((((int)now.veh_road[ Index(((int)((P1 *)_this)->vid), 2) ])*(2*3))+(((int)now.veh_dir[ Index(((int)((P1 *)_this)->vid), 2) ])*3))+(((int)((P1 *)_this)->_7_2_cur_slot)+1)), 78) ])==0)))
			goto S_455_1;
S_449_0: /* 2 */
		now.road_slots[ Index((((now.veh_road[ Index(((P1 *)_this)->vid, 2) ]*(2*3))+(now.veh_dir[ Index(((P1 *)_this)->vid, 2) ]*3))+((P1 *)_this)->_7_2_cur_slot), 78) ] = 0;
#ifdef VAR_RANGES
		logval("road_slots[(((veh_road[VehicleFSM:vid]*(2*3))+(veh_dir[VehicleFSM:vid]*3))+VehicleFSM:cur_slot)]", ((int)now.road_slots[ Index((((((int)now.veh_road[ Index(((int)((P1 *)_this)->vid), 2) ])*(2*3))+(((int)now.veh_dir[ Index(((int)((P1 *)_this)->vid), 2) ])*3))+((int)((P1 *)_this)->_7_2_cur_slot)), 78) ]));
#endif
		;
S_450_0: /* 2 */
		now.veh_slot[ Index(((P1 *)_this)->vid, 2) ] = (((int)((P1 *)_this)->_7_2_cur_slot)+1);
#ifdef VAR_RANGES
		logval("veh_slot[VehicleFSM:vid]", ((int)now.veh_slot[ Index(((int)((P1 *)_this)->vid), 2) ]));
#endif
		;
S_451_0: /* 2 */
		now.road_slots[ Index((((now.veh_road[ Index(((P1 *)_this)->vid, 2) ]*(2*3))+(now.veh_dir[ Index(((P1 *)_this)->vid, 2) ]*3))+(((P1 *)_this)->_7_2_cur_slot+1)), 78) ] = (((int)((P1 *)_this)->vid)+1);
#ifdef VAR_RANGES
		logval("road_slots[(((veh_road[VehicleFSM:vid]*(2*3))+(veh_dir[VehicleFSM:vid]*3))+(VehicleFSM:cur_slot+1))]", ((int)now.road_slots[ Index((((((int)now.veh_road[ Index(((int)((P1 *)_this)->vid), 2) ])*(2*3))+(((int)now.veh_dir[ Index(((int)((P1 *)_this)->vid), 2) ])*3))+(((int)((P1 *)_this)->_7_2_cur_slot)+1)), 78) ]));
#endif
		;
S_452_0: /* 2 */
		now.moved_this_step[ Index(((P1 *)_this)->vid, 2) ] = 1;
#ifdef VAR_RANGES
		logval("moved_this_step[VehicleFSM:vid]", ((int)now.moved_this_step[ Index(((int)((P1 *)_this)->vid), 2) ]));
#endif
		;
		goto S_456_0;
S_455_1: /* 3 */
S_453_0: /* 2 */
		/* else */;
S_454_0: /* 2 */
		if (!(1))
			Uerror("block in d_step seq");
		goto S_456_0;
S_455_2: /* 3 */
		Uerror("blocking sel in d_step (nr.21, near line 716)");
S_456_0: /* 2 */
		goto S_586_0;
S_585_1: /* 3 */
S_457_0: /* 2 */
		if (!((((int)((P1 *)_this)->_7_2_cur_slot)==((int)((P1 *)_this)->_7_2_last_sl))))
			goto S_585_2;
S_458_0: /* 2 */
		((P1 *)_this)->_7_2_dest_node = 255;
#ifdef VAR_RANGES
		logval("VehicleFSM:dest_node", ((int)((P1 *)_this)->_7_2_dest_node));
#endif
		;
S_459_0: /* 2 */
		((P1 *)_this)->_7_2_in_heading = 255;
#ifdef VAR_RANGES
		logval("VehicleFSM:in_heading", ((int)((P1 *)_this)->_7_2_in_heading));
#endif
		;
S_540_0: /* 2 */
S_460_0: /* 2 */
		if (!(((((int)now.veh_road[ Index(((int)((P1 *)_this)->vid), 2) ])==0)&&(((int)now.veh_dir[ Index(((int)((P1 *)_this)->vid), 2) ])==0))))
			goto S_540_1;
S_461_0: /* 2 */
		((P1 *)_this)->_7_2_dest_node = 1;
#ifdef VAR_RANGES
		logval("VehicleFSM:dest_node", ((int)((P1 *)_this)->_7_2_dest_node));
#endif
		;
S_462_0: /* 2 */
		((P1 *)_this)->_7_2_in_heading = 3;
#ifdef VAR_RANGES
		logval("VehicleFSM:in_heading", ((int)((P1 *)_this)->_7_2_in_heading));
#endif
		;
		goto S_541_0;
S_540_1: /* 3 */
S_463_0: /* 2 */
		if (!(((((int)now.veh_road[ Index(((int)((P1 *)_this)->vid), 2) ])==0)&&(((int)now.veh_dir[ Index(((int)((P1 *)_this)->vid), 2) ])==1))))
			goto S_540_2;
S_464_0: /* 2 */
		((P1 *)_this)->_7_2_dest_node = 0;
#ifdef VAR_RANGES
		logval("VehicleFSM:dest_node", ((int)((P1 *)_this)->_7_2_dest_node));
#endif
		;
S_465_0: /* 2 */
		((P1 *)_this)->_7_2_in_heading = 1;
#ifdef VAR_RANGES
		logval("VehicleFSM:in_heading", ((int)((P1 *)_this)->_7_2_in_heading));
#endif
		;
		goto S_541_0;
S_540_2: /* 3 */
S_466_0: /* 2 */
		if (!(((((int)now.veh_road[ Index(((int)((P1 *)_this)->vid), 2) ])==1)&&(((int)now.veh_dir[ Index(((int)((P1 *)_this)->vid), 2) ])==0))))
			goto S_540_3;
S_467_0: /* 2 */
		((P1 *)_this)->_7_2_dest_node = 2;
#ifdef VAR_RANGES
		logval("VehicleFSM:dest_node", ((int)((P1 *)_this)->_7_2_dest_node));
#endif
		;
S_468_0: /* 2 */
		((P1 *)_this)->_7_2_in_heading = 3;
#ifdef VAR_RANGES
		logval("VehicleFSM:in_heading", ((int)((P1 *)_this)->_7_2_in_heading));
#endif
		;
		goto S_541_0;
S_540_3: /* 3 */
S_469_0: /* 2 */
		if (!(((((int)now.veh_road[ Index(((int)((P1 *)_this)->vid), 2) ])==1)&&(((int)now.veh_dir[ Index(((int)((P1 *)_this)->vid), 2) ])==1))))
			goto S_540_4;
S_470_0: /* 2 */
		((P1 *)_this)->_7_2_dest_node = 1;
#ifdef VAR_RANGES
		logval("VehicleFSM:dest_node", ((int)((P1 *)_this)->_7_2_dest_node));
#endif
		;
S_471_0: /* 2 */
		((P1 *)_this)->_7_2_in_heading = 1;
#ifdef VAR_RANGES
		logval("VehicleFSM:in_heading", ((int)((P1 *)_this)->_7_2_in_heading));
#endif
		;
		goto S_541_0;
S_540_4: /* 3 */
S_472_0: /* 2 */
		if (!(((((int)now.veh_road[ Index(((int)((P1 *)_this)->vid), 2) ])==2)&&(((int)now.veh_dir[ Index(((int)((P1 *)_this)->vid), 2) ])==0))))
			goto S_540_5;
S_473_0: /* 2 */
		((P1 *)_this)->_7_2_dest_node = 4;
#ifdef VAR_RANGES
		logval("VehicleFSM:dest_node", ((int)((P1 *)_this)->_7_2_dest_node));
#endif
		;
S_474_0: /* 2 */
		((P1 *)_this)->_7_2_in_heading = 3;
#ifdef VAR_RANGES
		logval("VehicleFSM:in_heading", ((int)((P1 *)_this)->_7_2_in_heading));
#endif
		;
		goto S_541_0;
S_540_5: /* 3 */
S_475_0: /* 2 */
		if (!(((((int)now.veh_road[ Index(((int)((P1 *)_this)->vid), 2) ])==2)&&(((int)now.veh_dir[ Index(((int)((P1 *)_this)->vid), 2) ])==1))))
			goto S_540_6;
S_476_0: /* 2 */
		((P1 *)_this)->_7_2_dest_node = 3;
#ifdef VAR_RANGES
		logval("VehicleFSM:dest_node", ((int)((P1 *)_this)->_7_2_dest_node));
#endif
		;
S_477_0: /* 2 */
		((P1 *)_this)->_7_2_in_heading = 1;
#ifdef VAR_RANGES
		logval("VehicleFSM:in_heading", ((int)((P1 *)_this)->_7_2_in_heading));
#endif
		;
		goto S_541_0;
S_540_6: /* 3 */
S_478_0: /* 2 */
		if (!(((((int)now.veh_road[ Index(((int)((P1 *)_this)->vid), 2) ])==3)&&(((int)now.veh_dir[ Index(((int)((P1 *)_this)->vid), 2) ])==0))))
			goto S_540_7;
S_479_0: /* 2 */
		((P1 *)_this)->_7_2_dest_node = 5;
#ifdef VAR_RANGES
		logval("VehicleFSM:dest_node", ((int)((P1 *)_this)->_7_2_dest_node));
#endif
		;
S_480_0: /* 2 */
		((P1 *)_this)->_7_2_in_heading = 3;
#ifdef VAR_RANGES
		logval("VehicleFSM:in_heading", ((int)((P1 *)_this)->_7_2_in_heading));
#endif
		;
		goto S_541_0;
S_540_7: /* 3 */
S_481_0: /* 2 */
		if (!(((((int)now.veh_road[ Index(((int)((P1 *)_this)->vid), 2) ])==3)&&(((int)now.veh_dir[ Index(((int)((P1 *)_this)->vid), 2) ])==1))))
			goto S_540_8;
S_482_0: /* 2 */
		((P1 *)_this)->_7_2_dest_node = 4;
#ifdef VAR_RANGES
		logval("VehicleFSM:dest_node", ((int)((P1 *)_this)->_7_2_dest_node));
#endif
		;
S_483_0: /* 2 */
		((P1 *)_this)->_7_2_in_heading = 1;
#ifdef VAR_RANGES
		logval("VehicleFSM:in_heading", ((int)((P1 *)_this)->_7_2_in_heading));
#endif
		;
		goto S_541_0;
S_540_8: /* 3 */
S_484_0: /* 2 */
		if (!(((((int)now.veh_road[ Index(((int)((P1 *)_this)->vid), 2) ])==4)&&(((int)now.veh_dir[ Index(((int)((P1 *)_this)->vid), 2) ])==0))))
			goto S_540_9;
S_485_0: /* 2 */
		((P1 *)_this)->_7_2_dest_node = 7;
#ifdef VAR_RANGES
		logval("VehicleFSM:dest_node", ((int)((P1 *)_this)->_7_2_dest_node));
#endif
		;
S_486_0: /* 2 */
		((P1 *)_this)->_7_2_in_heading = 3;
#ifdef VAR_RANGES
		logval("VehicleFSM:in_heading", ((int)((P1 *)_this)->_7_2_in_heading));
#endif
		;
		goto S_541_0;
S_540_9: /* 3 */
S_487_0: /* 2 */
		if (!(((((int)now.veh_road[ Index(((int)((P1 *)_this)->vid), 2) ])==4)&&(((int)now.veh_dir[ Index(((int)((P1 *)_this)->vid), 2) ])==1))))
			goto S_540_10;
S_488_0: /* 2 */
		((P1 *)_this)->_7_2_dest_node = 6;
#ifdef VAR_RANGES
		logval("VehicleFSM:dest_node", ((int)((P1 *)_this)->_7_2_dest_node));
#endif
		;
S_489_0: /* 2 */
		((P1 *)_this)->_7_2_in_heading = 1;
#ifdef VAR_RANGES
		logval("VehicleFSM:in_heading", ((int)((P1 *)_this)->_7_2_in_heading));
#endif
		;
		goto S_541_0;
S_540_10: /* 3 */
S_490_0: /* 2 */
		if (!(((((int)now.veh_road[ Index(((int)((P1 *)_this)->vid), 2) ])==5)&&(((int)now.veh_dir[ Index(((int)((P1 *)_this)->vid), 2) ])==0))))
			goto S_540_11;
S_491_0: /* 2 */
		((P1 *)_this)->_7_2_dest_node = 8;
#ifdef VAR_RANGES
		logval("VehicleFSM:dest_node", ((int)((P1 *)_this)->_7_2_dest_node));
#endif
		;
S_492_0: /* 2 */
		((P1 *)_this)->_7_2_in_heading = 3;
#ifdef VAR_RANGES
		logval("VehicleFSM:in_heading", ((int)((P1 *)_this)->_7_2_in_heading));
#endif
		;
		goto S_541_0;
S_540_11: /* 3 */
S_493_0: /* 2 */
		if (!(((((int)now.veh_road[ Index(((int)((P1 *)_this)->vid), 2) ])==5)&&(((int)now.veh_dir[ Index(((int)((P1 *)_this)->vid), 2) ])==1))))
			goto S_540_12;
S_494_0: /* 2 */
		((P1 *)_this)->_7_2_dest_node = 7;
#ifdef VAR_RANGES
		logval("VehicleFSM:dest_node", ((int)((P1 *)_this)->_7_2_dest_node));
#endif
		;
S_495_0: /* 2 */
		((P1 *)_this)->_7_2_in_heading = 1;
#ifdef VAR_RANGES
		logval("VehicleFSM:in_heading", ((int)((P1 *)_this)->_7_2_in_heading));
#endif
		;
		goto S_541_0;
S_540_12: /* 3 */
S_496_0: /* 2 */
		if (!(((((int)now.veh_road[ Index(((int)((P1 *)_this)->vid), 2) ])==6)&&(((int)now.veh_dir[ Index(((int)((P1 *)_this)->vid), 2) ])==0))))
			goto S_540_13;
S_497_0: /* 2 */
		((P1 *)_this)->_7_2_dest_node = 3;
#ifdef VAR_RANGES
		logval("VehicleFSM:dest_node", ((int)((P1 *)_this)->_7_2_dest_node));
#endif
		;
S_498_0: /* 2 */
		((P1 *)_this)->_7_2_in_heading = 0;
#ifdef VAR_RANGES
		logval("VehicleFSM:in_heading", ((int)((P1 *)_this)->_7_2_in_heading));
#endif
		;
		goto S_541_0;
S_540_13: /* 3 */
S_499_0: /* 2 */
		if (!(((((int)now.veh_road[ Index(((int)((P1 *)_this)->vid), 2) ])==6)&&(((int)now.veh_dir[ Index(((int)((P1 *)_this)->vid), 2) ])==1))))
			goto S_540_14;
S_500_0: /* 2 */
		((P1 *)_this)->_7_2_dest_node = 0;
#ifdef VAR_RANGES
		logval("VehicleFSM:dest_node", ((int)((P1 *)_this)->_7_2_dest_node));
#endif
		;
S_501_0: /* 2 */
		((P1 *)_this)->_7_2_in_heading = 2;
#ifdef VAR_RANGES
		logval("VehicleFSM:in_heading", ((int)((P1 *)_this)->_7_2_in_heading));
#endif
		;
		goto S_541_0;
S_540_14: /* 3 */
S_502_0: /* 2 */
		if (!(((((int)now.veh_road[ Index(((int)((P1 *)_this)->vid), 2) ])==7)&&(((int)now.veh_dir[ Index(((int)((P1 *)_this)->vid), 2) ])==0))))
			goto S_540_15;
S_503_0: /* 2 */
		((P1 *)_this)->_7_2_dest_node = 4;
#ifdef VAR_RANGES
		logval("VehicleFSM:dest_node", ((int)((P1 *)_this)->_7_2_dest_node));
#endif
		;
S_504_0: /* 2 */
		((P1 *)_this)->_7_2_in_heading = 0;
#ifdef VAR_RANGES
		logval("VehicleFSM:in_heading", ((int)((P1 *)_this)->_7_2_in_heading));
#endif
		;
		goto S_541_0;
S_540_15: /* 3 */
S_505_0: /* 2 */
		if (!(((((int)now.veh_road[ Index(((int)((P1 *)_this)->vid), 2) ])==7)&&(((int)now.veh_dir[ Index(((int)((P1 *)_this)->vid), 2) ])==1))))
			goto S_540_16;
S_506_0: /* 2 */
		((P1 *)_this)->_7_2_dest_node = 1;
#ifdef VAR_RANGES
		logval("VehicleFSM:dest_node", ((int)((P1 *)_this)->_7_2_dest_node));
#endif
		;
S_507_0: /* 2 */
		((P1 *)_this)->_7_2_in_heading = 2;
#ifdef VAR_RANGES
		logval("VehicleFSM:in_heading", ((int)((P1 *)_this)->_7_2_in_heading));
#endif
		;
		goto S_541_0;
S_540_16: /* 3 */
S_508_0: /* 2 */
		if (!(((((int)now.veh_road[ Index(((int)((P1 *)_this)->vid), 2) ])==8)&&(((int)now.veh_dir[ Index(((int)((P1 *)_this)->vid), 2) ])==0))))
			goto S_540_17;
S_509_0: /* 2 */
		((P1 *)_this)->_7_2_dest_node = 5;
#ifdef VAR_RANGES
		logval("VehicleFSM:dest_node", ((int)((P1 *)_this)->_7_2_dest_node));
#endif
		;
S_510_0: /* 2 */
		((P1 *)_this)->_7_2_in_heading = 0;
#ifdef VAR_RANGES
		logval("VehicleFSM:in_heading", ((int)((P1 *)_this)->_7_2_in_heading));
#endif
		;
		goto S_541_0;
S_540_17: /* 3 */
S_511_0: /* 2 */
		if (!(((((int)now.veh_road[ Index(((int)((P1 *)_this)->vid), 2) ])==8)&&(((int)now.veh_dir[ Index(((int)((P1 *)_this)->vid), 2) ])==1))))
			goto S_540_18;
S_512_0: /* 2 */
		((P1 *)_this)->_7_2_dest_node = 2;
#ifdef VAR_RANGES
		logval("VehicleFSM:dest_node", ((int)((P1 *)_this)->_7_2_dest_node));
#endif
		;
S_513_0: /* 2 */
		((P1 *)_this)->_7_2_in_heading = 2;
#ifdef VAR_RANGES
		logval("VehicleFSM:in_heading", ((int)((P1 *)_this)->_7_2_in_heading));
#endif
		;
		goto S_541_0;
S_540_18: /* 3 */
S_514_0: /* 2 */
		if (!(((((int)now.veh_road[ Index(((int)((P1 *)_this)->vid), 2) ])==9)&&(((int)now.veh_dir[ Index(((int)((P1 *)_this)->vid), 2) ])==0))))
			goto S_540_19;
S_515_0: /* 2 */
		((P1 *)_this)->_7_2_dest_node = 6;
#ifdef VAR_RANGES
		logval("VehicleFSM:dest_node", ((int)((P1 *)_this)->_7_2_dest_node));
#endif
		;
S_516_0: /* 2 */
		((P1 *)_this)->_7_2_in_heading = 0;
#ifdef VAR_RANGES
		logval("VehicleFSM:in_heading", ((int)((P1 *)_this)->_7_2_in_heading));
#endif
		;
		goto S_541_0;
S_540_19: /* 3 */
S_517_0: /* 2 */
		if (!(((((int)now.veh_road[ Index(((int)((P1 *)_this)->vid), 2) ])==9)&&(((int)now.veh_dir[ Index(((int)((P1 *)_this)->vid), 2) ])==1))))
			goto S_540_20;
S_518_0: /* 2 */
		((P1 *)_this)->_7_2_dest_node = 3;
#ifdef VAR_RANGES
		logval("VehicleFSM:dest_node", ((int)((P1 *)_this)->_7_2_dest_node));
#endif
		;
S_519_0: /* 2 */
		((P1 *)_this)->_7_2_in_heading = 2;
#ifdef VAR_RANGES
		logval("VehicleFSM:in_heading", ((int)((P1 *)_this)->_7_2_in_heading));
#endif
		;
		goto S_541_0;
S_540_20: /* 3 */
S_520_0: /* 2 */
		if (!(((((int)now.veh_road[ Index(((int)((P1 *)_this)->vid), 2) ])==10)&&(((int)now.veh_dir[ Index(((int)((P1 *)_this)->vid), 2) ])==0))))
			goto S_540_21;
S_521_0: /* 2 */
		((P1 *)_this)->_7_2_dest_node = 7;
#ifdef VAR_RANGES
		logval("VehicleFSM:dest_node", ((int)((P1 *)_this)->_7_2_dest_node));
#endif
		;
S_522_0: /* 2 */
		((P1 *)_this)->_7_2_in_heading = 0;
#ifdef VAR_RANGES
		logval("VehicleFSM:in_heading", ((int)((P1 *)_this)->_7_2_in_heading));
#endif
		;
		goto S_541_0;
S_540_21: /* 3 */
S_523_0: /* 2 */
		if (!(((((int)now.veh_road[ Index(((int)((P1 *)_this)->vid), 2) ])==10)&&(((int)now.veh_dir[ Index(((int)((P1 *)_this)->vid), 2) ])==1))))
			goto S_540_22;
S_524_0: /* 2 */
		((P1 *)_this)->_7_2_dest_node = 4;
#ifdef VAR_RANGES
		logval("VehicleFSM:dest_node", ((int)((P1 *)_this)->_7_2_dest_node));
#endif
		;
S_525_0: /* 2 */
		((P1 *)_this)->_7_2_in_heading = 2;
#ifdef VAR_RANGES
		logval("VehicleFSM:in_heading", ((int)((P1 *)_this)->_7_2_in_heading));
#endif
		;
		goto S_541_0;
S_540_22: /* 3 */
S_526_0: /* 2 */
		if (!(((((int)now.veh_road[ Index(((int)((P1 *)_this)->vid), 2) ])==11)&&(((int)now.veh_dir[ Index(((int)((P1 *)_this)->vid), 2) ])==0))))
			goto S_540_23;
S_527_0: /* 2 */
		((P1 *)_this)->_7_2_dest_node = 8;
#ifdef VAR_RANGES
		logval("VehicleFSM:dest_node", ((int)((P1 *)_this)->_7_2_dest_node));
#endif
		;
S_528_0: /* 2 */
		((P1 *)_this)->_7_2_in_heading = 0;
#ifdef VAR_RANGES
		logval("VehicleFSM:in_heading", ((int)((P1 *)_this)->_7_2_in_heading));
#endif
		;
		goto S_541_0;
S_540_23: /* 3 */
S_529_0: /* 2 */
		if (!(((((int)now.veh_road[ Index(((int)((P1 *)_this)->vid), 2) ])==11)&&(((int)now.veh_dir[ Index(((int)((P1 *)_this)->vid), 2) ])==1))))
			goto S_540_24;
S_530_0: /* 2 */
		((P1 *)_this)->_7_2_dest_node = 5;
#ifdef VAR_RANGES
		logval("VehicleFSM:dest_node", ((int)((P1 *)_this)->_7_2_dest_node));
#endif
		;
S_531_0: /* 2 */
		((P1 *)_this)->_7_2_in_heading = 2;
#ifdef VAR_RANGES
		logval("VehicleFSM:in_heading", ((int)((P1 *)_this)->_7_2_in_heading));
#endif
		;
		goto S_541_0;
S_540_24: /* 3 */
S_532_0: /* 2 */
		if (!(((((int)now.veh_road[ Index(((int)((P1 *)_this)->vid), 2) ])==12)&&(((int)now.veh_dir[ Index(((int)((P1 *)_this)->vid), 2) ])==0))))
			goto S_540_25;
S_533_0: /* 2 */
		((P1 *)_this)->_7_2_dest_node = 9;
#ifdef VAR_RANGES
		logval("VehicleFSM:dest_node", ((int)((P1 *)_this)->_7_2_dest_node));
#endif
		;
S_534_0: /* 2 */
		((P1 *)_this)->_7_2_in_heading = 255;
#ifdef VAR_RANGES
		logval("VehicleFSM:in_heading", ((int)((P1 *)_this)->_7_2_in_heading));
#endif
		;
		goto S_541_0;
S_540_25: /* 3 */
S_535_0: /* 2 */
		if (!(((((int)now.veh_road[ Index(((int)((P1 *)_this)->vid), 2) ])==12)&&(((int)now.veh_dir[ Index(((int)((P1 *)_this)->vid), 2) ])==1))))
			goto S_540_26;
S_536_0: /* 2 */
		((P1 *)_this)->_7_2_dest_node = 0;
#ifdef VAR_RANGES
		logval("VehicleFSM:dest_node", ((int)((P1 *)_this)->_7_2_dest_node));
#endif
		;
S_537_0: /* 2 */
		((P1 *)_this)->_7_2_in_heading = 255;
#ifdef VAR_RANGES
		logval("VehicleFSM:in_heading", ((int)((P1 *)_this)->_7_2_in_heading));
#endif
		;
		goto S_541_0;
S_540_26: /* 3 */
S_538_0: /* 2 */
		/* else */;
S_539_0: /* 2 */
		((P1 *)_this)->_7_2_dest_node = 255;
#ifdef VAR_RANGES
		logval("VehicleFSM:dest_node", ((int)((P1 *)_this)->_7_2_dest_node));
#endif
		;
		goto S_541_0;
S_540_27: /* 3 */
		Uerror("blocking sel in d_step (nr.22, near line 730)");
S_541_0: /* 2 */
S_581_0: /* 2 */
S_542_0: /* 2 */
		if (!((((int)((P1 *)_this)->_7_2_dest_node)==255)))
			goto S_581_1;
S_543_0: /* 2 */
		if (!(1))
			Uerror("block in d_step seq");
		goto S_582_0;
S_581_1: /* 3 */
S_544_0: /* 2 */
		if (!(((((int)((P1 *)_this)->_7_2_dest_node)!=255)&&((int)now.node_occupied[ Index(((int)((P1 *)_this)->_7_2_dest_node), 10) ]))))
			goto S_581_2;
S_545_0: /* 2 */
		if (!(1))
			Uerror("block in d_step seq");
		goto S_582_0;
S_581_2: /* 3 */
S_546_0: /* 2 */
		if (!(((((int)((P1 *)_this)->_7_2_dest_node)!=255)&& !(((int)now.node_occupied[ Index(((int)((P1 *)_this)->_7_2_dest_node), 10) ])))))
			goto S_581_3;
S_547_0: /* 2 */
		now.road_slots[ Index((((now.veh_road[ Index(((P1 *)_this)->vid, 2) ]*(2*3))+(now.veh_dir[ Index(((P1 *)_this)->vid, 2) ]*3))+((P1 *)_this)->_7_2_cur_slot), 78) ] = 0;
#ifdef VAR_RANGES
		logval("road_slots[(((veh_road[VehicleFSM:vid]*(2*3))+(veh_dir[VehicleFSM:vid]*3))+VehicleFSM:cur_slot)]", ((int)now.road_slots[ Index((((((int)now.veh_road[ Index(((int)((P1 *)_this)->vid), 2) ])*(2*3))+(((int)now.veh_dir[ Index(((int)((P1 *)_this)->vid), 2) ])*3))+((int)((P1 *)_this)->_7_2_cur_slot)), 78) ]));
#endif
		;
S_548_0: /* 2 */
		now.veh_mode[ Index(((P1 *)_this)->vid, 2) ] = 0;
#ifdef VAR_RANGES
		logval("veh_mode[VehicleFSM:vid]", ((int)now.veh_mode[ Index(((int)((P1 *)_this)->vid), 2) ]));
#endif
		;
S_549_0: /* 2 */
		now.veh_node[ Index(((P1 *)_this)->vid, 2) ] = ((int)((P1 *)_this)->_7_2_dest_node);
#ifdef VAR_RANGES
		logval("veh_node[VehicleFSM:vid]", ((int)now.veh_node[ Index(((int)((P1 *)_this)->vid), 2) ]));
#endif
		;
S_550_0: /* 2 */
		now.veh_heading[ Index(((P1 *)_this)->vid, 2) ] = ((int)((P1 *)_this)->_7_2_in_heading);
#ifdef VAR_RANGES
		logval("veh_heading[VehicleFSM:vid]", ((int)now.veh_heading[ Index(((int)((P1 *)_this)->vid), 2) ]));
#endif
		;
S_551_0: /* 2 */
		now.node_occupied[ Index(((P1 *)_this)->_7_2_dest_node, 10) ] = 1;
#ifdef VAR_RANGES
		logval("node_occupied[VehicleFSM:dest_node]", ((int)now.node_occupied[ Index(((int)((P1 *)_this)->_7_2_dest_node), 10) ]));
#endif
		;
S_552_0: /* 2 */
		now.crossing_count[ Index(((P1 *)_this)->_7_2_dest_node, 10) ] = (((int)now.crossing_count[ Index(((int)((P1 *)_this)->_7_2_dest_node), 10) ])+1);
#ifdef VAR_RANGES
		logval("crossing_count[VehicleFSM:dest_node]", ((int)now.crossing_count[ Index(((int)((P1 *)_this)->_7_2_dest_node), 10) ]));
#endif
		;
S_553_0: /* 2 */
		now.moved_this_step[ Index(((P1 *)_this)->vid, 2) ] = 1;
#ifdef VAR_RANGES
		logval("moved_this_step[VehicleFSM:vid]", ((int)now.moved_this_step[ Index(((int)((P1 *)_this)->vid), 2) ]));
#endif
		;
S_579_0: /* 2 */
S_554_0: /* 2 */
		if (!((((int)((P1 *)_this)->_7_2_dest_node)==((int)now.veh_dest[ Index(((int)((P1 *)_this)->vid), 2) ]))))
			goto S_579_1;
S_563_0: /* 2 */
S_555_0: /* 2 */
		if (!((((int)((P1 *)_this)->_7_2_dest_node)==6)))
			goto S_563_1;
S_556_0: /* 2 */
		now.visited_B[ Index(((P1 *)_this)->vid, 2) ] = 1;
#ifdef VAR_RANGES
		logval("visited_B[VehicleFSM:vid]", ((int)now.visited_B[ Index(((int)((P1 *)_this)->vid), 2) ]));
#endif
		;
		goto S_564_0;
S_563_1: /* 3 */
S_557_0: /* 2 */
		if (!((((int)((P1 *)_this)->_7_2_dest_node)==8)))
			goto S_563_2;
S_558_0: /* 2 */
		now.visited_C[ Index(((P1 *)_this)->vid, 2) ] = 1;
#ifdef VAR_RANGES
		logval("visited_C[VehicleFSM:vid]", ((int)now.visited_C[ Index(((int)((P1 *)_this)->vid), 2) ]));
#endif
		;
		goto S_564_0;
S_563_2: /* 3 */
S_559_0: /* 2 */
		if (!((((int)((P1 *)_this)->_7_2_dest_node)==2)))
			goto S_563_3;
S_560_0: /* 2 */
		now.visited_D[ Index(((P1 *)_this)->vid, 2) ] = 1;
#ifdef VAR_RANGES
		logval("visited_D[VehicleFSM:vid]", ((int)now.visited_D[ Index(((int)((P1 *)_this)->vid), 2) ]));
#endif
		;
		goto S_564_0;
S_563_3: /* 3 */
S_561_0: /* 2 */
		/* else */;
S_562_0: /* 2 */
		if (!(1))
			Uerror("block in d_step seq");
		goto S_564_0;
S_563_4: /* 3 */
		Uerror("blocking sel in d_step (nr.23, near line 776)");
S_564_0: /* 2 */
S_575_0: /* 2 */
S_565_0: /* 2 */
		if (!((((int)now.veh_dest_idx[ Index(((int)((P1 *)_this)->vid), 2) ])<3)))
			goto S_575_1;
S_566_0: /* 2 */
		now.veh_dest_idx[ Index(((P1 *)_this)->vid, 2) ] = (((int)now.veh_dest_idx[ Index(((int)((P1 *)_this)->vid), 2) ])+1);
#ifdef VAR_RANGES
		logval("veh_dest_idx[VehicleFSM:vid]", ((int)now.veh_dest_idx[ Index(((int)((P1 *)_this)->vid), 2) ]));
#endif
		;
S_567_0: /* 2 */
		now.veh_dest[ Index(((P1 *)_this)->vid, 2) ] = ((int)now.tour_stops[ Index(((((int)((P1 *)_this)->vid)*4)+((int)now.veh_dest_idx[ Index(((int)((P1 *)_this)->vid), 2) ])), 8) ]);
#ifdef VAR_RANGES
		logval("veh_dest[VehicleFSM:vid]", ((int)now.veh_dest[ Index(((int)((P1 *)_this)->vid), 2) ]));
#endif
		;
		goto S_576_0;
S_575_1: /* 3 */
S_568_0: /* 2 */
		if (!((((int)now.veh_dest_idx[ Index(((int)((P1 *)_this)->vid), 2) ])>=3)))
			goto S_575_2;
S_573_0: /* 2 */
S_569_0: /* 2 */
		if (!(((((((int)((P1 *)_this)->_7_2_dest_node)==9)&&((int)now.visited_B[ Index(((int)((P1 *)_this)->vid), 2) ]))&&((int)now.visited_C[ Index(((int)((P1 *)_this)->vid), 2) ]))&&((int)now.visited_D[ Index(((int)((P1 *)_this)->vid), 2) ]))))
			goto S_573_1;
S_570_0: /* 2 */
		now.returned_A[ Index(((P1 *)_this)->vid, 2) ] = 1;
#ifdef VAR_RANGES
		logval("returned_A[VehicleFSM:vid]", ((int)now.returned_A[ Index(((int)((P1 *)_this)->vid), 2) ]));
#endif
		;
		goto S_574_0;
S_573_1: /* 3 */
S_571_0: /* 2 */
		/* else */;
S_572_0: /* 2 */
		if (!(1))
			Uerror("block in d_step seq");
		goto S_574_0;
S_573_2: /* 3 */
		Uerror("blocking sel in d_step (nr.24, near line 790)");
S_574_0: /* 2 */
		goto S_576_0;
S_575_2: /* 3 */
		Uerror("blocking sel in d_step (nr.25, near line 784)");
S_576_0: /* 2 */
		goto S_580_0;
S_579_1: /* 3 */
S_577_0: /* 2 */
		/* else */;
S_578_0: /* 2 */
		if (!(1))
			Uerror("block in d_step seq");
		goto S_580_0;
S_579_2: /* 3 */
		Uerror("blocking sel in d_step (nr.26, near line 773)");
S_580_0: /* 2 */
		goto S_582_0;
S_581_3: /* 3 */
		Uerror("blocking sel in d_step (nr.27, near line 760)");
S_582_0: /* 2 */
		goto S_586_0;
S_585_2: /* 3 */
S_583_0: /* 2 */
		/* else */;
S_584_0: /* 2 */
		if (!(1))
			Uerror("block in d_step seq");
		goto S_586_0;
S_585_3: /* 3 */
		Uerror("blocking sel in d_step (nr.28, near line 714)");
S_586_0: /* 2 */
		goto S_590_0;
S_589_2: /* 3 */
S_587_0: /* 2 */
		/* else */;
S_588_0: /* 2 */
		if (!(1))
			Uerror("block in d_step seq");
		goto S_590_0;
S_589_3: /* 3 */
		Uerror("blocking sel in d_step (nr.29, near line 576)");
S_590_0: /* 2 */
		goto S_592_0;
S_591_3: /* 3 */
		Uerror("blocking sel in d_step (nr.30, near line 571)");
S_592_0: /* 2 */
		goto S_594_0;
S_594_0: /* 1 */

#if defined(C_States) && (HAS_TRACK==1)
		c_update((uchar *) &(now.c_state[0]));
#endif
		_m = 3; goto P999;

	case 73: // STATE 353 - phase_c_model.pml:807 - [done_vehicle[vid]!0] (0:0:0 - 1)
		IfNotBlocked
		reached[1][353] = 1;
		if (q_len(now.done_vehicle[ Index(((int)((P1 *)_this)->vid), 2) ]))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", now.done_vehicle[ Index(((int)((P1 *)_this)->vid), 2) ]);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		
		qsend(now.done_vehicle[ Index(((int)((P1 *)_this)->vid), 2) ], 0, 0, 1);
		{ boq = now.done_vehicle[ Index(((int)((P1 *)_this)->vid), 2) ]; };
		_m = 2; goto P999; /* 0 */
	case 74: // STATE 357 - phase_c_model.pml:809 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[1][357] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC InfraFSM */
	case 75: // STATE 1 - phase_c_model.pml:232 - [tick_infra?dummy] (0:0:2 - 1)
		reached[0][1] = 1;
		if (boq != now.tick_infra) continue;
		if (q_len(now.tick_infra) == 0) continue;

		XX=1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = ((int)((P0 *)_this)->dummy);
		;
		((P0 *)_this)->dummy = qrecv(now.tick_infra, XX-1, 0, 1);
#ifdef VAR_RANGES
		logval("InfraFSM:dummy", ((int)((P0 *)_this)->dummy));
#endif
		;
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", now.tick_infra);
			sprintf(simtmp, "%d", ((int)((P0 *)_this)->dummy)); strcat(simvals, simtmp);
		}
#endif
		if (q_zero(now.tick_infra))
		{	boq = -1;
#ifndef NOFAIR
			if (fairness
			&& !(trpt->o_pm&32)
			&& (now._a_t&2)
			&&  now._cnt[now._a_t&1] == II+2)
			{	now._cnt[now._a_t&1] -= 1;
#ifdef VERI
				if (II == 1)
					now._cnt[now._a_t&1] = 1;
#endif
#ifdef DEBUG
			printf("%3ld: proc %d fairness ", depth, II);
			printf("Rule 2: --cnt to %d (%d)\n",
				now._cnt[now._a_t&1], now._a_t);
#endif
				trpt->o_pm |= (32|64);
			}
#endif

		};
		if (TstOnly) return 1; /* TT */
		/* dead 2: dummy */  (trpt+1)->bup.ovals[1] = ((P0 *)_this)->dummy;
#ifdef HAS_CODE
		if (!readtrail)
#endif
			((P0 *)_this)->dummy = 0;
		_m = 4; goto P999; /* 0 */
	case 76: // STATE 213 - phase_c_model.pml:234 - [D_STEP234]
		IfNotBlocked

		reached[0][213] = 1;
		reached[0][t->st] = 1;
		reached[0][tt] = 1;

		if (TstOnly) return 1;

		sv_save();
		S_001_0: /* 2 */
		((P0 *)_this)->_6_1_nid = 0;
#ifdef VAR_RANGES
		logval("InfraFSM:nid", ((int)((P0 *)_this)->_6_1_nid));
#endif
		;
S_002_0: /* 2 */
		((P0 *)_this)->_6_1_d = 0;
#ifdef VAR_RANGES
		logval("InfraFSM:d", ((int)((P0 *)_this)->_6_1_d));
#endif
		;
S_003_0: /* 2 */
		((P0 *)_this)->_6_1_i = 0;
#ifdef VAR_RANGES
		logval("InfraFSM:i", ((int)((P0 *)_this)->_6_1_i));
#endif
		;
S_004_0: /* 2 */
		((P0 *)_this)->_6_1_counts[0] = 0;
#ifdef VAR_RANGES
		logval("InfraFSM:counts[0]", ((int)((P0 *)_this)->_6_1_counts[0]));
#endif
		;
S_005_0: /* 2 */
		((P0 *)_this)->_6_1_best_dir = 0;
#ifdef VAR_RANGES
		logval("InfraFSM:best_dir", ((int)((P0 *)_this)->_6_1_best_dir));
#endif
		;
S_006_0: /* 2 */
		((P0 *)_this)->_6_1_best_count = 0;
#ifdef VAR_RANGES
		logval("InfraFSM:best_count", ((int)((P0 *)_this)->_6_1_best_count));
#endif
		;
S_007_0: /* 2 */
		((P0 *)_this)->_6_1_starved_dir = 0;
#ifdef VAR_RANGES
		logval("InfraFSM:starved_dir", ((int)((P0 *)_this)->_6_1_starved_dir));
#endif
		;
S_008_0: /* 2 */
		((P0 *)_this)->_6_1_road_id = 0;
#ifdef VAR_RANGES
		logval("InfraFSM:road_id", ((int)((P0 *)_this)->_6_1_road_id));
#endif
		;
S_009_0: /* 2 */
		((P0 *)_this)->_6_1_lane_dir = 0;
#ifdef VAR_RANGES
		logval("InfraFSM:lane_dir", ((int)((P0 *)_this)->_6_1_lane_dir));
#endif
		;
S_010_0: /* 2 */
		((P0 *)_this)->_6_1_nid = 0;
#ifdef VAR_RANGES
		logval("InfraFSM:nid", ((int)((P0 *)_this)->_6_1_nid));
#endif
		;
S_210_0: /* 2 */
S_209_0: /* 2 */
S_011_0: /* 2 */
		if (!((((int)((P0 *)_this)->_6_1_nid)<9)))
			goto S_209_1;
S_012_0: /* 2 */
		((P0 *)_this)->_6_1_d = 0;
#ifdef VAR_RANGES
		logval("InfraFSM:d", ((int)((P0 *)_this)->_6_1_d));
#endif
		;
S_124_0: /* 2 */
S_123_0: /* 2 */
S_013_0: /* 2 */
		if (!((((int)((P0 *)_this)->_6_1_d)<4)))
			goto S_123_1;
S_014_0: /* 2 */
		((P0 *)_this)->_6_1_counts[ Index(((P0 *)_this)->_6_1_d, 4) ] = 0;
#ifdef VAR_RANGES
		logval("InfraFSM:counts[InfraFSM:d]", ((int)((P0 *)_this)->_6_1_counts[ Index(((int)((P0 *)_this)->_6_1_d), 4) ]));
#endif
		;
S_118_0: /* 2 */
S_015_0: /* 2 */
		if (!(((int)now.light_enabled[ Index(((((int)((P0 *)_this)->_6_1_nid)*4)+((int)((P0 *)_this)->_6_1_d)), 40) ])))
			goto S_118_1;
S_016_0: /* 2 */
		((P0 *)_this)->_6_1_road_id = 255;
#ifdef VAR_RANGES
		logval("InfraFSM:road_id", ((int)((P0 *)_this)->_6_1_road_id));
#endif
		;
S_017_0: /* 2 */
		((P0 *)_this)->_6_1_lane_dir = 0;
#ifdef VAR_RANGES
		logval("InfraFSM:lane_dir", ((int)((P0 *)_this)->_6_1_lane_dir));
#endif
		;
S_095_0: /* 2 */
S_018_0: /* 2 */
		if (!(((((int)((P0 *)_this)->_6_1_nid)==0)&&(((int)((P0 *)_this)->_6_1_d)==1))))
			goto S_095_1;
S_019_0: /* 2 */
		((P0 *)_this)->_6_1_road_id = 0;
#ifdef VAR_RANGES
		logval("InfraFSM:road_id", ((int)((P0 *)_this)->_6_1_road_id));
#endif
		;
S_020_0: /* 2 */
		((P0 *)_this)->_6_1_lane_dir = 1;
#ifdef VAR_RANGES
		logval("InfraFSM:lane_dir", ((int)((P0 *)_this)->_6_1_lane_dir));
#endif
		;
		goto S_096_0;
S_095_1: /* 3 */
S_021_0: /* 2 */
		if (!(((((int)((P0 *)_this)->_6_1_nid)==0)&&(((int)((P0 *)_this)->_6_1_d)==2))))
			goto S_095_2;
S_022_0: /* 2 */
		((P0 *)_this)->_6_1_road_id = 6;
#ifdef VAR_RANGES
		logval("InfraFSM:road_id", ((int)((P0 *)_this)->_6_1_road_id));
#endif
		;
S_023_0: /* 2 */
		((P0 *)_this)->_6_1_lane_dir = 1;
#ifdef VAR_RANGES
		logval("InfraFSM:lane_dir", ((int)((P0 *)_this)->_6_1_lane_dir));
#endif
		;
		goto S_096_0;
S_095_2: /* 3 */
S_024_0: /* 2 */
		if (!(((((int)((P0 *)_this)->_6_1_nid)==0)&&(((int)((P0 *)_this)->_6_1_d)==3))))
			goto S_095_3;
S_025_0: /* 2 */
		((P0 *)_this)->_6_1_road_id = 12;
#ifdef VAR_RANGES
		logval("InfraFSM:road_id", ((int)((P0 *)_this)->_6_1_road_id));
#endif
		;
S_026_0: /* 2 */
		((P0 *)_this)->_6_1_lane_dir = 1;
#ifdef VAR_RANGES
		logval("InfraFSM:lane_dir", ((int)((P0 *)_this)->_6_1_lane_dir));
#endif
		;
		goto S_096_0;
S_095_3: /* 3 */
S_027_0: /* 2 */
		if (!(((((int)((P0 *)_this)->_6_1_nid)==1)&&(((int)((P0 *)_this)->_6_1_d)==1))))
			goto S_095_4;
S_028_0: /* 2 */
		((P0 *)_this)->_6_1_road_id = 1;
#ifdef VAR_RANGES
		logval("InfraFSM:road_id", ((int)((P0 *)_this)->_6_1_road_id));
#endif
		;
S_029_0: /* 2 */
		((P0 *)_this)->_6_1_lane_dir = 1;
#ifdef VAR_RANGES
		logval("InfraFSM:lane_dir", ((int)((P0 *)_this)->_6_1_lane_dir));
#endif
		;
		goto S_096_0;
S_095_4: /* 3 */
S_030_0: /* 2 */
		if (!(((((int)((P0 *)_this)->_6_1_nid)==1)&&(((int)((P0 *)_this)->_6_1_d)==2))))
			goto S_095_5;
S_031_0: /* 2 */
		((P0 *)_this)->_6_1_road_id = 7;
#ifdef VAR_RANGES
		logval("InfraFSM:road_id", ((int)((P0 *)_this)->_6_1_road_id));
#endif
		;
S_032_0: /* 2 */
		((P0 *)_this)->_6_1_lane_dir = 1;
#ifdef VAR_RANGES
		logval("InfraFSM:lane_dir", ((int)((P0 *)_this)->_6_1_lane_dir));
#endif
		;
		goto S_096_0;
S_095_5: /* 3 */
S_033_0: /* 2 */
		if (!(((((int)((P0 *)_this)->_6_1_nid)==1)&&(((int)((P0 *)_this)->_6_1_d)==3))))
			goto S_095_6;
S_034_0: /* 2 */
		((P0 *)_this)->_6_1_road_id = 0;
#ifdef VAR_RANGES
		logval("InfraFSM:road_id", ((int)((P0 *)_this)->_6_1_road_id));
#endif
		;
S_035_0: /* 2 */
		((P0 *)_this)->_6_1_lane_dir = 0;
#ifdef VAR_RANGES
		logval("InfraFSM:lane_dir", ((int)((P0 *)_this)->_6_1_lane_dir));
#endif
		;
		goto S_096_0;
S_095_6: /* 3 */
S_036_0: /* 2 */
		if (!(((((int)((P0 *)_this)->_6_1_nid)==2)&&(((int)((P0 *)_this)->_6_1_d)==2))))
			goto S_095_7;
S_037_0: /* 2 */
		((P0 *)_this)->_6_1_road_id = 8;
#ifdef VAR_RANGES
		logval("InfraFSM:road_id", ((int)((P0 *)_this)->_6_1_road_id));
#endif
		;
S_038_0: /* 2 */
		((P0 *)_this)->_6_1_lane_dir = 1;
#ifdef VAR_RANGES
		logval("InfraFSM:lane_dir", ((int)((P0 *)_this)->_6_1_lane_dir));
#endif
		;
		goto S_096_0;
S_095_7: /* 3 */
S_039_0: /* 2 */
		if (!(((((int)((P0 *)_this)->_6_1_nid)==2)&&(((int)((P0 *)_this)->_6_1_d)==3))))
			goto S_095_8;
S_040_0: /* 2 */
		((P0 *)_this)->_6_1_road_id = 1;
#ifdef VAR_RANGES
		logval("InfraFSM:road_id", ((int)((P0 *)_this)->_6_1_road_id));
#endif
		;
S_041_0: /* 2 */
		((P0 *)_this)->_6_1_lane_dir = 0;
#ifdef VAR_RANGES
		logval("InfraFSM:lane_dir", ((int)((P0 *)_this)->_6_1_lane_dir));
#endif
		;
		goto S_096_0;
S_095_8: /* 3 */
S_042_0: /* 2 */
		if (!(((((int)((P0 *)_this)->_6_1_nid)==3)&&(((int)((P0 *)_this)->_6_1_d)==0))))
			goto S_095_9;
S_043_0: /* 2 */
		((P0 *)_this)->_6_1_road_id = 6;
#ifdef VAR_RANGES
		logval("InfraFSM:road_id", ((int)((P0 *)_this)->_6_1_road_id));
#endif
		;
S_044_0: /* 2 */
		((P0 *)_this)->_6_1_lane_dir = 0;
#ifdef VAR_RANGES
		logval("InfraFSM:lane_dir", ((int)((P0 *)_this)->_6_1_lane_dir));
#endif
		;
		goto S_096_0;
S_095_9: /* 3 */
S_045_0: /* 2 */
		if (!(((((int)((P0 *)_this)->_6_1_nid)==3)&&(((int)((P0 *)_this)->_6_1_d)==1))))
			goto S_095_10;
S_046_0: /* 2 */
		((P0 *)_this)->_6_1_road_id = 2;
#ifdef VAR_RANGES
		logval("InfraFSM:road_id", ((int)((P0 *)_this)->_6_1_road_id));
#endif
		;
S_047_0: /* 2 */
		((P0 *)_this)->_6_1_lane_dir = 1;
#ifdef VAR_RANGES
		logval("InfraFSM:lane_dir", ((int)((P0 *)_this)->_6_1_lane_dir));
#endif
		;
		goto S_096_0;
S_095_10: /* 3 */
S_048_0: /* 2 */
		if (!(((((int)((P0 *)_this)->_6_1_nid)==3)&&(((int)((P0 *)_this)->_6_1_d)==2))))
			goto S_095_11;
S_049_0: /* 2 */
		((P0 *)_this)->_6_1_road_id = 9;
#ifdef VAR_RANGES
		logval("InfraFSM:road_id", ((int)((P0 *)_this)->_6_1_road_id));
#endif
		;
S_050_0: /* 2 */
		((P0 *)_this)->_6_1_lane_dir = 1;
#ifdef VAR_RANGES
		logval("InfraFSM:lane_dir", ((int)((P0 *)_this)->_6_1_lane_dir));
#endif
		;
		goto S_096_0;
S_095_11: /* 3 */
S_051_0: /* 2 */
		if (!(((((int)((P0 *)_this)->_6_1_nid)==4)&&(((int)((P0 *)_this)->_6_1_d)==0))))
			goto S_095_12;
S_052_0: /* 2 */
		((P0 *)_this)->_6_1_road_id = 7;
#ifdef VAR_RANGES
		logval("InfraFSM:road_id", ((int)((P0 *)_this)->_6_1_road_id));
#endif
		;
S_053_0: /* 2 */
		((P0 *)_this)->_6_1_lane_dir = 0;
#ifdef VAR_RANGES
		logval("InfraFSM:lane_dir", ((int)((P0 *)_this)->_6_1_lane_dir));
#endif
		;
		goto S_096_0;
S_095_12: /* 3 */
S_054_0: /* 2 */
		if (!(((((int)((P0 *)_this)->_6_1_nid)==4)&&(((int)((P0 *)_this)->_6_1_d)==1))))
			goto S_095_13;
S_055_0: /* 2 */
		((P0 *)_this)->_6_1_road_id = 3;
#ifdef VAR_RANGES
		logval("InfraFSM:road_id", ((int)((P0 *)_this)->_6_1_road_id));
#endif
		;
S_056_0: /* 2 */
		((P0 *)_this)->_6_1_lane_dir = 1;
#ifdef VAR_RANGES
		logval("InfraFSM:lane_dir", ((int)((P0 *)_this)->_6_1_lane_dir));
#endif
		;
		goto S_096_0;
S_095_13: /* 3 */
S_057_0: /* 2 */
		if (!(((((int)((P0 *)_this)->_6_1_nid)==4)&&(((int)((P0 *)_this)->_6_1_d)==2))))
			goto S_095_14;
S_058_0: /* 2 */
		((P0 *)_this)->_6_1_road_id = 10;
#ifdef VAR_RANGES
		logval("InfraFSM:road_id", ((int)((P0 *)_this)->_6_1_road_id));
#endif
		;
S_059_0: /* 2 */
		((P0 *)_this)->_6_1_lane_dir = 1;
#ifdef VAR_RANGES
		logval("InfraFSM:lane_dir", ((int)((P0 *)_this)->_6_1_lane_dir));
#endif
		;
		goto S_096_0;
S_095_14: /* 3 */
S_060_0: /* 2 */
		if (!(((((int)((P0 *)_this)->_6_1_nid)==4)&&(((int)((P0 *)_this)->_6_1_d)==3))))
			goto S_095_15;
S_061_0: /* 2 */
		((P0 *)_this)->_6_1_road_id = 2;
#ifdef VAR_RANGES
		logval("InfraFSM:road_id", ((int)((P0 *)_this)->_6_1_road_id));
#endif
		;
S_062_0: /* 2 */
		((P0 *)_this)->_6_1_lane_dir = 0;
#ifdef VAR_RANGES
		logval("InfraFSM:lane_dir", ((int)((P0 *)_this)->_6_1_lane_dir));
#endif
		;
		goto S_096_0;
S_095_15: /* 3 */
S_063_0: /* 2 */
		if (!(((((int)((P0 *)_this)->_6_1_nid)==5)&&(((int)((P0 *)_this)->_6_1_d)==0))))
			goto S_095_16;
S_064_0: /* 2 */
		((P0 *)_this)->_6_1_road_id = 8;
#ifdef VAR_RANGES
		logval("InfraFSM:road_id", ((int)((P0 *)_this)->_6_1_road_id));
#endif
		;
S_065_0: /* 2 */
		((P0 *)_this)->_6_1_lane_dir = 0;
#ifdef VAR_RANGES
		logval("InfraFSM:lane_dir", ((int)((P0 *)_this)->_6_1_lane_dir));
#endif
		;
		goto S_096_0;
S_095_16: /* 3 */
S_066_0: /* 2 */
		if (!(((((int)((P0 *)_this)->_6_1_nid)==5)&&(((int)((P0 *)_this)->_6_1_d)==2))))
			goto S_095_17;
S_067_0: /* 2 */
		((P0 *)_this)->_6_1_road_id = 11;
#ifdef VAR_RANGES
		logval("InfraFSM:road_id", ((int)((P0 *)_this)->_6_1_road_id));
#endif
		;
S_068_0: /* 2 */
		((P0 *)_this)->_6_1_lane_dir = 1;
#ifdef VAR_RANGES
		logval("InfraFSM:lane_dir", ((int)((P0 *)_this)->_6_1_lane_dir));
#endif
		;
		goto S_096_0;
S_095_17: /* 3 */
S_069_0: /* 2 */
		if (!(((((int)((P0 *)_this)->_6_1_nid)==5)&&(((int)((P0 *)_this)->_6_1_d)==3))))
			goto S_095_18;
S_070_0: /* 2 */
		((P0 *)_this)->_6_1_road_id = 3;
#ifdef VAR_RANGES
		logval("InfraFSM:road_id", ((int)((P0 *)_this)->_6_1_road_id));
#endif
		;
S_071_0: /* 2 */
		((P0 *)_this)->_6_1_lane_dir = 0;
#ifdef VAR_RANGES
		logval("InfraFSM:lane_dir", ((int)((P0 *)_this)->_6_1_lane_dir));
#endif
		;
		goto S_096_0;
S_095_18: /* 3 */
S_072_0: /* 2 */
		if (!(((((int)((P0 *)_this)->_6_1_nid)==6)&&(((int)((P0 *)_this)->_6_1_d)==0))))
			goto S_095_19;
S_073_0: /* 2 */
		((P0 *)_this)->_6_1_road_id = 9;
#ifdef VAR_RANGES
		logval("InfraFSM:road_id", ((int)((P0 *)_this)->_6_1_road_id));
#endif
		;
S_074_0: /* 2 */
		((P0 *)_this)->_6_1_lane_dir = 0;
#ifdef VAR_RANGES
		logval("InfraFSM:lane_dir", ((int)((P0 *)_this)->_6_1_lane_dir));
#endif
		;
		goto S_096_0;
S_095_19: /* 3 */
S_075_0: /* 2 */
		if (!(((((int)((P0 *)_this)->_6_1_nid)==6)&&(((int)((P0 *)_this)->_6_1_d)==1))))
			goto S_095_20;
S_076_0: /* 2 */
		((P0 *)_this)->_6_1_road_id = 4;
#ifdef VAR_RANGES
		logval("InfraFSM:road_id", ((int)((P0 *)_this)->_6_1_road_id));
#endif
		;
S_077_0: /* 2 */
		((P0 *)_this)->_6_1_lane_dir = 1;
#ifdef VAR_RANGES
		logval("InfraFSM:lane_dir", ((int)((P0 *)_this)->_6_1_lane_dir));
#endif
		;
		goto S_096_0;
S_095_20: /* 3 */
S_078_0: /* 2 */
		if (!(((((int)((P0 *)_this)->_6_1_nid)==7)&&(((int)((P0 *)_this)->_6_1_d)==0))))
			goto S_095_21;
S_079_0: /* 2 */
		((P0 *)_this)->_6_1_road_id = 10;
#ifdef VAR_RANGES
		logval("InfraFSM:road_id", ((int)((P0 *)_this)->_6_1_road_id));
#endif
		;
S_080_0: /* 2 */
		((P0 *)_this)->_6_1_lane_dir = 0;
#ifdef VAR_RANGES
		logval("InfraFSM:lane_dir", ((int)((P0 *)_this)->_6_1_lane_dir));
#endif
		;
		goto S_096_0;
S_095_21: /* 3 */
S_081_0: /* 2 */
		if (!(((((int)((P0 *)_this)->_6_1_nid)==7)&&(((int)((P0 *)_this)->_6_1_d)==1))))
			goto S_095_22;
S_082_0: /* 2 */
		((P0 *)_this)->_6_1_road_id = 5;
#ifdef VAR_RANGES
		logval("InfraFSM:road_id", ((int)((P0 *)_this)->_6_1_road_id));
#endif
		;
S_083_0: /* 2 */
		((P0 *)_this)->_6_1_lane_dir = 1;
#ifdef VAR_RANGES
		logval("InfraFSM:lane_dir", ((int)((P0 *)_this)->_6_1_lane_dir));
#endif
		;
		goto S_096_0;
S_095_22: /* 3 */
S_084_0: /* 2 */
		if (!(((((int)((P0 *)_this)->_6_1_nid)==7)&&(((int)((P0 *)_this)->_6_1_d)==3))))
			goto S_095_23;
S_085_0: /* 2 */
		((P0 *)_this)->_6_1_road_id = 4;
#ifdef VAR_RANGES
		logval("InfraFSM:road_id", ((int)((P0 *)_this)->_6_1_road_id));
#endif
		;
S_086_0: /* 2 */
		((P0 *)_this)->_6_1_lane_dir = 0;
#ifdef VAR_RANGES
		logval("InfraFSM:lane_dir", ((int)((P0 *)_this)->_6_1_lane_dir));
#endif
		;
		goto S_096_0;
S_095_23: /* 3 */
S_087_0: /* 2 */
		if (!(((((int)((P0 *)_this)->_6_1_nid)==8)&&(((int)((P0 *)_this)->_6_1_d)==0))))
			goto S_095_24;
S_088_0: /* 2 */
		((P0 *)_this)->_6_1_road_id = 11;
#ifdef VAR_RANGES
		logval("InfraFSM:road_id", ((int)((P0 *)_this)->_6_1_road_id));
#endif
		;
S_089_0: /* 2 */
		((P0 *)_this)->_6_1_lane_dir = 0;
#ifdef VAR_RANGES
		logval("InfraFSM:lane_dir", ((int)((P0 *)_this)->_6_1_lane_dir));
#endif
		;
		goto S_096_0;
S_095_24: /* 3 */
S_090_0: /* 2 */
		if (!(((((int)((P0 *)_this)->_6_1_nid)==8)&&(((int)((P0 *)_this)->_6_1_d)==3))))
			goto S_095_25;
S_091_0: /* 2 */
		((P0 *)_this)->_6_1_road_id = 5;
#ifdef VAR_RANGES
		logval("InfraFSM:road_id", ((int)((P0 *)_this)->_6_1_road_id));
#endif
		;
S_092_0: /* 2 */
		((P0 *)_this)->_6_1_lane_dir = 0;
#ifdef VAR_RANGES
		logval("InfraFSM:lane_dir", ((int)((P0 *)_this)->_6_1_lane_dir));
#endif
		;
		goto S_096_0;
S_095_25: /* 3 */
S_093_0: /* 2 */
		/* else */;
S_094_0: /* 2 */
		if (!(1))
			Uerror("block in d_step seq");
		goto S_096_0;
S_095_26: /* 3 */
		Uerror("blocking sel in d_step (nr.31, near line 255)");
S_096_0: /* 2 */
S_114_0: /* 2 */
S_097_0: /* 2 */
		if (!((((int)((P0 *)_this)->_6_1_road_id)!=255)))
			goto S_114_1;
S_098_0: /* 2 */
		((P0 *)_this)->_6_1_i = 0;
#ifdef VAR_RANGES
		logval("InfraFSM:i", ((int)((P0 *)_this)->_6_1_i));
#endif
		;
S_110_0: /* 2 */
S_109_0: /* 2 */
S_099_0: /* 2 */
		if (!((((int)((P0 *)_this)->_6_1_i)<3)))
			goto S_109_1;
S_104_0: /* 2 */
S_100_0: /* 2 */
		if (!((((int)now.road_slots[ Index((((((int)((P0 *)_this)->_6_1_road_id)*(2*3))+(((int)((P0 *)_this)->_6_1_lane_dir)*3))+((int)((P0 *)_this)->_6_1_i)), 78) ])!=0)))
			goto S_104_1;
S_101_0: /* 2 */
		((P0 *)_this)->_6_1_counts[ Index(((P0 *)_this)->_6_1_d, 4) ] = (((int)((P0 *)_this)->_6_1_counts[ Index(((int)((P0 *)_this)->_6_1_d), 4) ])+1);
#ifdef VAR_RANGES
		logval("InfraFSM:counts[InfraFSM:d]", ((int)((P0 *)_this)->_6_1_counts[ Index(((int)((P0 *)_this)->_6_1_d), 4) ]));
#endif
		;
		goto S_105_0;
S_104_1: /* 3 */
S_102_0: /* 2 */
		/* else */;
S_103_0: /* 2 */
		if (!(1))
			Uerror("block in d_step seq");
		goto S_105_0;
S_104_2: /* 3 */
		Uerror("blocking sel in d_step (nr.32, near line 298)");
S_105_0: /* 2 */
S_106_0: /* 2 */
		((P0 *)_this)->_6_1_i = (((int)((P0 *)_this)->_6_1_i)+1);
#ifdef VAR_RANGES
		logval("InfraFSM:i", ((int)((P0 *)_this)->_6_1_i));
#endif
		;
		goto S_110_0; /* ';' */
S_109_1: /* 3 */
S_107_0: /* 2 */
		if (!((((int)((P0 *)_this)->_6_1_i)>=3)))
			goto S_109_2;
S_108_0: /* 2 */
		goto S_120_0;	/* 'goto' */
S_109_2: /* 3 */
		Uerror("blocking sel in d_step (nr.33, near line 296)");
S_111_0: /* 2 */
		goto S_120_0;	/* 'break' */
		goto S_115_0;
S_114_1: /* 3 */
S_112_0: /* 2 */
		/* else */;
S_113_0: /* 2 */
		if (!(1))
			Uerror("block in d_step seq");
		goto S_115_0;
S_114_2: /* 3 */
		Uerror("blocking sel in d_step (nr.34, near line 293)");
S_115_0: /* 2 */
		goto S_119_0;
S_118_1: /* 3 */
S_116_0: /* 2 */
		/* else */;
S_117_0: /* 2 */
		if (!(1))
			Uerror("block in d_step seq");
		goto S_119_0;
S_118_2: /* 3 */
		Uerror("blocking sel in d_step (nr.35, near line 249)");
S_119_0: /* 2 */
S_120_0: /* 2 */
		((P0 *)_this)->_6_1_d = (((int)((P0 *)_this)->_6_1_d)+1);
#ifdef VAR_RANGES
		logval("InfraFSM:d", ((int)((P0 *)_this)->_6_1_d));
#endif
		;
		goto S_124_0; /* ';' */
S_123_1: /* 3 */
S_121_0: /* 2 */
		if (!((((int)((P0 *)_this)->_6_1_d)>=4)))
			goto S_123_2;
S_122_0: /* 2 */
		goto S_126_0;	/* 'goto' */
S_123_2: /* 3 */
		Uerror("blocking sel in d_step (nr.36, near line 246)");
S_125_0: /* 2 */
		goto S_126_0;	/* 'break' */
S_126_0: /* 2 */
		((P0 *)_this)->_6_1_starved_dir = 255;
#ifdef VAR_RANGES
		logval("InfraFSM:starved_dir", ((int)((P0 *)_this)->_6_1_starved_dir));
#endif
		;
S_127_0: /* 2 */
		((P0 *)_this)->_6_1_d = 0;
#ifdef VAR_RANGES
		logval("InfraFSM:d", ((int)((P0 *)_this)->_6_1_d));
#endif
		;
S_140_0: /* 2 */
S_139_0: /* 2 */
S_128_0: /* 2 */
		if (!((((int)((P0 *)_this)->_6_1_d)<4)))
			goto S_139_1;
S_134_0: /* 2 */
S_129_0: /* 2 */
		if (!((((int)now.light_enabled[ Index(((((int)((P0 *)_this)->_6_1_nid)*4)+((int)((P0 *)_this)->_6_1_d)), 40) ])&&(((int)now.red_streak[ Index(((((int)((P0 *)_this)->_6_1_nid)*4)+((int)((P0 *)_this)->_6_1_d)), 40) ])>=4))))
			goto S_134_1;
S_130_0: /* 2 */
		((P0 *)_this)->_6_1_starved_dir = ((int)((P0 *)_this)->_6_1_d);
#ifdef VAR_RANGES
		logval("InfraFSM:starved_dir", ((int)((P0 *)_this)->_6_1_starved_dir));
#endif
		;
S_131_0: /* 2 */
		goto S_185_0;	/* 'goto' */
S_134_1: /* 3 */
S_132_0: /* 2 */
		/* else */;
S_133_0: /* 2 */
		if (!(1))
			Uerror("block in d_step seq");
		goto S_135_0;
S_134_2: /* 3 */
		Uerror("blocking sel in d_step (nr.37, near line 318)");
S_135_0: /* 2 */
S_136_0: /* 2 */
		((P0 *)_this)->_6_1_d = (((int)((P0 *)_this)->_6_1_d)+1);
#ifdef VAR_RANGES
		logval("InfraFSM:d", ((int)((P0 *)_this)->_6_1_d));
#endif
		;
		goto S_140_0; /* ';' */
S_139_1: /* 3 */
S_137_0: /* 2 */
		if (!((((int)((P0 *)_this)->_6_1_d)>=4)))
			goto S_139_2;
S_138_0: /* 2 */
		goto S_185_0;	/* 'goto' */
		goto S_140_0; /* ';' */
S_139_2: /* 3 */
		Uerror("blocking sel in d_step (nr.38, near line 316)");
S_141_0: /* 2 */
		goto S_185_0;	/* 'break' */
S_185_0: /* 2 */
S_142_0: /* 2 */
		if (!((((int)((P0 *)_this)->_6_1_starved_dir)!=255)))
			goto S_185_1;
S_143_0: /* 2 */
		now.light_green[ Index(((P0 *)_this)->_6_1_nid, 10) ] = ((int)((P0 *)_this)->_6_1_starved_dir);
#ifdef VAR_RANGES
		logval("light_green[InfraFSM:nid]", ((int)now.light_green[ Index(((int)((P0 *)_this)->_6_1_nid), 10) ]));
#endif
		;
		goto S_186_0;
S_185_1: /* 3 */
S_144_0: /* 2 */
		if (!((((int)((P0 *)_this)->_6_1_starved_dir)==255)))
			goto S_185_2;
S_145_0: /* 2 */
		((P0 *)_this)->_6_1_best_dir = 255;
#ifdef VAR_RANGES
		logval("InfraFSM:best_dir", ((int)((P0 *)_this)->_6_1_best_dir));
#endif
		;
S_146_0: /* 2 */
		((P0 *)_this)->_6_1_best_count = 0;
#ifdef VAR_RANGES
		logval("InfraFSM:best_count", ((int)((P0 *)_this)->_6_1_best_count));
#endif
		;
S_147_0: /* 2 */
		((P0 *)_this)->_6_1_d = 0;
#ifdef VAR_RANGES
		logval("InfraFSM:d", ((int)((P0 *)_this)->_6_1_d));
#endif
		;
S_162_0: /* 2 */
S_161_0: /* 2 */
S_148_0: /* 2 */
		if (!((((int)((P0 *)_this)->_6_1_d)<4)))
			goto S_161_1;
S_156_0: /* 2 */
S_149_0: /* 2 */
		if (!((((int)now.light_enabled[ Index(((((int)((P0 *)_this)->_6_1_nid)*4)+((int)((P0 *)_this)->_6_1_d)), 40) ])&&(((int)((P0 *)_this)->_6_1_counts[ Index(((int)((P0 *)_this)->_6_1_d), 4) ])>((int)((P0 *)_this)->_6_1_best_count)))))
			goto S_156_1;
S_150_0: /* 2 */
		((P0 *)_this)->_6_1_best_count = ((int)((P0 *)_this)->_6_1_counts[ Index(((int)((P0 *)_this)->_6_1_d), 4) ]);
#ifdef VAR_RANGES
		logval("InfraFSM:best_count", ((int)((P0 *)_this)->_6_1_best_count));
#endif
		;
S_151_0: /* 2 */
		((P0 *)_this)->_6_1_best_dir = ((int)((P0 *)_this)->_6_1_d);
#ifdef VAR_RANGES
		logval("InfraFSM:best_dir", ((int)((P0 *)_this)->_6_1_best_dir));
#endif
		;
		goto S_157_0;
S_156_1: /* 3 */
S_152_0: /* 2 */
		if (!(((((int)now.light_enabled[ Index(((((int)((P0 *)_this)->_6_1_nid)*4)+((int)((P0 *)_this)->_6_1_d)), 40) ])&&(((int)((P0 *)_this)->_6_1_counts[ Index(((int)((P0 *)_this)->_6_1_d), 4) ])==((int)((P0 *)_this)->_6_1_best_count)))&&(((int)((P0 *)_this)->_6_1_best_dir)==255))))
			goto S_156_2;
S_153_0: /* 2 */
		((P0 *)_this)->_6_1_best_dir = ((int)((P0 *)_this)->_6_1_d);
#ifdef VAR_RANGES
		logval("InfraFSM:best_dir", ((int)((P0 *)_this)->_6_1_best_dir));
#endif
		;
		goto S_157_0;
S_156_2: /* 3 */
S_154_0: /* 2 */
		/* else */;
S_155_0: /* 2 */
		if (!(1))
			Uerror("block in d_step seq");
		goto S_157_0;
S_156_3: /* 3 */
		Uerror("blocking sel in d_step (nr.39, near line 338)");
S_157_0: /* 2 */
S_158_0: /* 2 */
		((P0 *)_this)->_6_1_d = (((int)((P0 *)_this)->_6_1_d)+1);
#ifdef VAR_RANGES
		logval("InfraFSM:d", ((int)((P0 *)_this)->_6_1_d));
#endif
		;
		goto S_162_0; /* ';' */
S_161_1: /* 3 */
S_159_0: /* 2 */
		if (!((((int)((P0 *)_this)->_6_1_d)>=4)))
			goto S_161_2;
S_160_0: /* 2 */
		goto S_182_0;	/* 'goto' */
S_161_2: /* 3 */
		Uerror("blocking sel in d_step (nr.40, near line 336)");
S_163_0: /* 2 */
		goto S_182_0;	/* 'break' */
S_182_0: /* 2 */
S_164_0: /* 2 */
		if (!((((int)((P0 *)_this)->_6_1_best_dir)==255)))
			goto S_182_1;
S_165_0: /* 2 */
		((P0 *)_this)->_6_1_d = 0;
#ifdef VAR_RANGES
		logval("InfraFSM:d", ((int)((P0 *)_this)->_6_1_d));
#endif
		;
S_178_0: /* 2 */
S_177_0: /* 2 */
S_166_0: /* 2 */
		if (!((((int)((P0 *)_this)->_6_1_d)<4)))
			goto S_177_1;
S_172_0: /* 2 */
S_167_0: /* 2 */
		if (!(((int)now.light_enabled[ Index(((((int)((P0 *)_this)->_6_1_nid)*4)+((int)((P0 *)_this)->_6_1_d)), 40) ])))
			goto S_172_1;
S_168_0: /* 2 */
		((P0 *)_this)->_6_1_best_dir = ((int)((P0 *)_this)->_6_1_d);
#ifdef VAR_RANGES
		logval("InfraFSM:best_dir", ((int)((P0 *)_this)->_6_1_best_dir));
#endif
		;
S_169_0: /* 2 */
		goto S_184_0;	/* 'goto' */
S_172_1: /* 3 */
S_170_0: /* 2 */
		/* else */;
S_171_0: /* 2 */
		if (!(1))
			Uerror("block in d_step seq");
		goto S_173_0;
S_172_2: /* 3 */
		Uerror("blocking sel in d_step (nr.41, near line 354)");
S_173_0: /* 2 */
S_174_0: /* 2 */
		((P0 *)_this)->_6_1_d = (((int)((P0 *)_this)->_6_1_d)+1);
#ifdef VAR_RANGES
		logval("InfraFSM:d", ((int)((P0 *)_this)->_6_1_d));
#endif
		;
		goto S_178_0; /* ';' */
S_177_1: /* 3 */
S_175_0: /* 2 */
		if (!((((int)((P0 *)_this)->_6_1_d)>=4)))
			goto S_177_2;
S_176_0: /* 2 */
		goto S_184_0;	/* 'goto' */
		goto S_178_0; /* ';' */
S_177_2: /* 3 */
		Uerror("blocking sel in d_step (nr.42, near line 352)");
S_179_0: /* 2 */
		goto S_184_0;	/* 'break' */
		goto S_183_0;
S_182_1: /* 3 */
S_180_0: /* 2 */
		/* else */;
S_181_0: /* 2 */
		if (!(1))
			Uerror("block in d_step seq");
		goto S_183_0;
S_182_2: /* 3 */
		Uerror("blocking sel in d_step (nr.43, near line 349)");
S_183_0: /* 2 */
S_184_0: /* 2 */
		now.light_green[ Index(((P0 *)_this)->_6_1_nid, 10) ] = ((int)((P0 *)_this)->_6_1_best_dir);
#ifdef VAR_RANGES
		logval("light_green[InfraFSM:nid]", ((int)now.light_green[ Index(((int)((P0 *)_this)->_6_1_nid), 10) ]));
#endif
		;
		goto S_186_0;
S_185_2: /* 3 */
		Uerror("blocking sel in d_step (nr.44, near line 329)");
S_186_0: /* 2 */
S_187_0: /* 2 */
		((P0 *)_this)->_6_1_d = 0;
#ifdef VAR_RANGES
		logval("InfraFSM:d", ((int)((P0 *)_this)->_6_1_d));
#endif
		;
S_204_0: /* 2 */
S_203_0: /* 2 */
S_188_0: /* 2 */
		if (!((((int)((P0 *)_this)->_6_1_d)<4)))
			goto S_203_1;
S_198_0: /* 2 */
S_189_0: /* 2 */
		if (!(((int)now.light_enabled[ Index(((((int)((P0 *)_this)->_6_1_nid)*4)+((int)((P0 *)_this)->_6_1_d)), 40) ])))
			goto S_198_1;
S_194_0: /* 2 */
S_190_0: /* 2 */
		if (!((((int)((P0 *)_this)->_6_1_d)==((int)now.light_green[ Index(((int)((P0 *)_this)->_6_1_nid), 10) ]))))
			goto S_194_1;
S_191_0: /* 2 */
		now.red_streak[ Index(((((P0 *)_this)->_6_1_nid*4)+((P0 *)_this)->_6_1_d), 40) ] = 0;
#ifdef VAR_RANGES
		logval("red_streak[((InfraFSM:nid*4)+InfraFSM:d)]", ((int)now.red_streak[ Index(((((int)((P0 *)_this)->_6_1_nid)*4)+((int)((P0 *)_this)->_6_1_d)), 40) ]));
#endif
		;
		goto S_195_0;
S_194_1: /* 3 */
S_192_0: /* 2 */
		/* else */;
S_193_0: /* 2 */
		now.red_streak[ Index(((((P0 *)_this)->_6_1_nid*4)+((P0 *)_this)->_6_1_d), 40) ] = (((int)now.red_streak[ Index(((((int)((P0 *)_this)->_6_1_nid)*4)+((int)((P0 *)_this)->_6_1_d)), 40) ])+1);
#ifdef VAR_RANGES
		logval("red_streak[((InfraFSM:nid*4)+InfraFSM:d)]", ((int)now.red_streak[ Index(((((int)((P0 *)_this)->_6_1_nid)*4)+((int)((P0 *)_this)->_6_1_d)), 40) ]));
#endif
		;
		goto S_195_0;
S_194_2: /* 3 */
		Uerror("blocking sel in d_step (nr.45, near line 373)");
S_195_0: /* 2 */
		goto S_199_0;
S_198_1: /* 3 */
S_196_0: /* 2 */
		/* else */;
S_197_0: /* 2 */
		if (!(1))
			Uerror("block in d_step seq");
		goto S_199_0;
S_198_2: /* 3 */
		Uerror("blocking sel in d_step (nr.46, near line 371)");
S_199_0: /* 2 */
S_200_0: /* 2 */
		((P0 *)_this)->_6_1_d = (((int)((P0 *)_this)->_6_1_d)+1);
#ifdef VAR_RANGES
		logval("InfraFSM:d", ((int)((P0 *)_this)->_6_1_d));
#endif
		;
		goto S_204_0; /* ';' */
S_203_1: /* 3 */
S_201_0: /* 2 */
		if (!((((int)((P0 *)_this)->_6_1_d)>=4)))
			goto S_203_2;
S_202_0: /* 2 */
		goto S_206_0;	/* 'goto' */
S_203_2: /* 3 */
		Uerror("blocking sel in d_step (nr.47, near line 369)");
S_205_0: /* 2 */
		goto S_206_0;	/* 'break' */
S_206_0: /* 2 */
		((P0 *)_this)->_6_1_nid = (((int)((P0 *)_this)->_6_1_nid)+1);
#ifdef VAR_RANGES
		logval("InfraFSM:nid", ((int)((P0 *)_this)->_6_1_nid));
#endif
		;
		goto S_210_0; /* ';' */
S_209_1: /* 3 */
S_207_0: /* 2 */
		if (!((((int)((P0 *)_this)->_6_1_nid)>=9)))
			goto S_209_2;
S_208_0: /* 2 */
		goto S_211_0;	/* 'goto' */
S_209_2: /* 3 */
		Uerror("blocking sel in d_step (nr.48, near line 241)");
S_211_0: /* 2 */
		goto S_213_0;	/* 'break' */
S_213_0: /* 1 */

#if defined(C_States) && (HAS_TRACK==1)
		c_update((uchar *) &(now.c_state[0]));
#endif
		_m = 3; goto P999;

	case 77: // STATE 214 - phase_c_model.pml:391 - [nid2 = 0] (0:0:1 - 1)
		IfNotBlocked
		reached[0][214] = 1;
		(trpt+1)->bup.oval = ((int)((P0 *)_this)->nid2);
		((P0 *)_this)->nid2 = 0;
#ifdef VAR_RANGES
		logval("InfraFSM:nid2", ((int)((P0 *)_this)->nid2));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 78: // STATE 215 - phase_c_model.pml:392 - [((nid2<9))] (228:0:2 - 1)
		IfNotBlocked
		reached[0][215] = 1;
		if (!((((int)((P0 *)_this)->nid2)<9)))
			continue;
		/* merge: gc = 0(228, 216, 228) */
		reached[0][216] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = ((int)((P0 *)_this)->gc);
		((P0 *)_this)->gc = 0;
#ifdef VAR_RANGES
		logval("InfraFSM:gc", ((int)((P0 *)_this)->gc));
#endif
		;
		/* merge: d2 = 0(228, 217, 228) */
		reached[0][217] = 1;
		(trpt+1)->bup.ovals[1] = ((int)((P0 *)_this)->d2);
		((P0 *)_this)->d2 = 0;
#ifdef VAR_RANGES
		logval("InfraFSM:d2", ((int)((P0 *)_this)->d2));
#endif
		;
		/* merge: .(goto)(0, 229, 228) */
		reached[0][229] = 1;
		;
		_m = 3; goto P999; /* 3 */
	case 79: // STATE 218 - phase_c_model.pml:396 - [((d2<4))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][218] = 1;
		if (!((((int)((P0 *)_this)->d2)<4)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 80: // STATE 219 - phase_c_model.pml:398 - [((light_enabled[((nid2*4)+d2)]&&(d2==light_green[nid2])))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][219] = 1;
		if (!((((int)now.light_enabled[ Index(((((int)((P0 *)_this)->nid2)*4)+((int)((P0 *)_this)->d2)), 40) ])&&(((int)((P0 *)_this)->d2)==((int)now.light_green[ Index(((int)((P0 *)_this)->nid2), 10) ])))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 81: // STATE 220 - phase_c_model.pml:398 - [gc = (gc+1)] (0:228:2 - 1)
		IfNotBlocked
		reached[0][220] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = ((int)((P0 *)_this)->gc);
		((P0 *)_this)->gc = (((int)((P0 *)_this)->gc)+1);
#ifdef VAR_RANGES
		logval("InfraFSM:gc", ((int)((P0 *)_this)->gc));
#endif
		;
		/* merge: .(goto)(228, 224, 228) */
		reached[0][224] = 1;
		;
		/* merge: d2 = (d2+1)(228, 225, 228) */
		reached[0][225] = 1;
		(trpt+1)->bup.ovals[1] = ((int)((P0 *)_this)->d2);
		((P0 *)_this)->d2 = (((int)((P0 *)_this)->d2)+1);
#ifdef VAR_RANGES
		logval("InfraFSM:d2", ((int)((P0 *)_this)->d2));
#endif
		;
		/* merge: .(goto)(0, 229, 228) */
		reached[0][229] = 1;
		;
		_m = 3; goto P999; /* 3 */
	case 82: // STATE 222 - phase_c_model.pml:399 - [(1)] (228:0:1 - 1)
		IfNotBlocked
		reached[0][222] = 1;
		if (!(1))
			continue;
		/* merge: .(goto)(228, 224, 228) */
		reached[0][224] = 1;
		;
		/* merge: d2 = (d2+1)(228, 225, 228) */
		reached[0][225] = 1;
		(trpt+1)->bup.oval = ((int)((P0 *)_this)->d2);
		((P0 *)_this)->d2 = (((int)((P0 *)_this)->d2)+1);
#ifdef VAR_RANGES
		logval("InfraFSM:d2", ((int)((P0 *)_this)->d2));
#endif
		;
		/* merge: .(goto)(0, 229, 228) */
		reached[0][229] = 1;
		;
		_m = 3; goto P999; /* 3 */
	case 83: // STATE 225 - phase_c_model.pml:401 - [d2 = (d2+1)] (0:228:1 - 3)
		IfNotBlocked
		reached[0][225] = 1;
		(trpt+1)->bup.oval = ((int)((P0 *)_this)->d2);
		((P0 *)_this)->d2 = (((int)((P0 *)_this)->d2)+1);
#ifdef VAR_RANGES
		logval("InfraFSM:d2", ((int)((P0 *)_this)->d2));
#endif
		;
		/* merge: .(goto)(0, 229, 228) */
		reached[0][229] = 1;
		;
		_m = 3; goto P999; /* 1 */
	case 84: // STATE 226 - phase_c_model.pml:402 - [((d2>=4))] (235:0:2 - 1)
		IfNotBlocked
		reached[0][226] = 1;
		if (!((((int)((P0 *)_this)->d2)>=4)))
			continue;
		if (TstOnly) return 1; /* TT */
		/* dead 1: d2 */  (trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = ((P0 *)_this)->d2;
#ifdef HAS_CODE
		if (!readtrail)
#endif
			((P0 *)_this)->d2 = 0;
		/* merge: goto :b9(235, 227, 235) */
		reached[0][227] = 1;
		;
		/* merge: assert((gc==1))(235, 231, 235) */
		reached[0][231] = 1;
		spin_assert((((int)((P0 *)_this)->gc)==1), "(gc==1)", II, tt, t);
		/* merge: nid2 = (nid2+1)(235, 232, 235) */
		reached[0][232] = 1;
		(trpt+1)->bup.ovals[1] = ((int)((P0 *)_this)->nid2);
		((P0 *)_this)->nid2 = (((int)((P0 *)_this)->nid2)+1);
#ifdef VAR_RANGES
		logval("InfraFSM:nid2", ((int)((P0 *)_this)->nid2));
#endif
		;
		/* merge: .(goto)(0, 236, 235) */
		reached[0][236] = 1;
		;
		_m = 3; goto P999; /* 4 */
	case 85: // STATE 231 - phase_c_model.pml:404 - [assert((gc==1))] (0:235:1 - 3)
		IfNotBlocked
		reached[0][231] = 1;
		spin_assert((((int)((P0 *)_this)->gc)==1), "(gc==1)", II, tt, t);
		/* merge: nid2 = (nid2+1)(235, 232, 235) */
		reached[0][232] = 1;
		(trpt+1)->bup.oval = ((int)((P0 *)_this)->nid2);
		((P0 *)_this)->nid2 = (((int)((P0 *)_this)->nid2)+1);
#ifdef VAR_RANGES
		logval("InfraFSM:nid2", ((int)((P0 *)_this)->nid2));
#endif
		;
		/* merge: .(goto)(0, 236, 235) */
		reached[0][236] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 86: // STATE 233 - phase_c_model.pml:406 - [((nid2>=9))] (0:0:1 - 1)
		IfNotBlocked
		reached[0][233] = 1;
		if (!((((int)((P0 *)_this)->nid2)>=9)))
			continue;
		if (TstOnly) return 1; /* TT */
		/* dead 1: nid2 */  (trpt+1)->bup.oval = ((P0 *)_this)->nid2;
#ifdef HAS_CODE
		if (!readtrail)
#endif
			((P0 *)_this)->nid2 = 0;
		_m = 3; goto P999; /* 0 */
	case 87: // STATE 238 - phase_c_model.pml:409 - [done_infra!0] (0:0:0 - 3)
		IfNotBlocked
		reached[0][238] = 1;
		if (q_len(now.done_infra))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", now.done_infra);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		
		qsend(now.done_infra, 0, 0, 1);
		{ boq = now.done_infra; };
		_m = 2; goto P999; /* 0 */
	case 88: // STATE 242 - phase_c_model.pml:411 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[0][242] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */
	case  _T5:	/* np_ */
		if (!((!(trpt->o_pm&4) && !(trpt->tau&128))))
			continue;
		/* else fall through */
	case  _T2:	/* true */
		_m = 3; goto P999;
#undef rand
	}

