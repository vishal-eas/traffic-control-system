	switch (t->back) {
	default: Uerror("bad return move");
	case  0: goto R999; /* nothing to undo */

		 /* CLAIM valid_light_topology */
;
		
	case 3: // STATE 1
		goto R999;

	case 4: // STATE 10
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* CLAIM mutual_exclusion_lights */
;
		
	case 5: // STATE 1
		goto R999;

	case 6: // STATE 10
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* CLAIM fair_green_bounded */
;
		
	case 7: // STATE 1
		goto R999;

	case 8: // STATE 10
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* CLAIM eventual_green_bounded */
;
		
	case 9: // STATE 1
		goto R999;

	case 10: // STATE 10
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* CLAIM tour_closure */
;
		;
		
	case 12: // STATE 6
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* CLAIM visit_all_bcd */
;
		;
		
	case 14: // STATE 6
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* CLAIM no_uturn */
;
		
	case 15: // STATE 1
		goto R999;

	case 16: // STATE 10
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* CLAIM no_opposite_direction */
;
		
	case 17: // STATE 1
		goto R999;

	case 18: // STATE 10
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* CLAIM no_red_violation */
;
		
	case 19: // STATE 1
		goto R999;

	case 20: // STATE 10
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* CLAIM no_collision */
;
		
	case 21: // STATE 1
		goto R999;

	case 22: // STATE 10
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC :init: */

	case 23: // STATE 1
		;
		((P2 *)_this)->i = trpt->bup.oval;
		;
		goto R999;

	case 24: // STATE 4
		;
		((P2 *)_this)->i = trpt->bup.ovals[1];
		now.light_enabled[ Index(((P2 *)_this)->i, 40) ] = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;

	case 25: // STATE 46
		;
		((P2 *)_this)->i = trpt->bup.ovals[37];
		now.light_green[9] = trpt->bup.ovals[36];
		now.light_green[8] = trpt->bup.ovals[35];
		now.light_green[7] = trpt->bup.ovals[34];
		now.light_green[6] = trpt->bup.ovals[33];
		now.light_green[5] = trpt->bup.ovals[32];
		now.light_green[4] = trpt->bup.ovals[31];
		now.light_green[3] = trpt->bup.ovals[30];
		now.light_green[2] = trpt->bup.ovals[29];
		now.light_green[1] = trpt->bup.ovals[28];
		now.light_green[0] = trpt->bup.ovals[27];
		now.light_enabled[ Index(((9*4)+1), 40) ] = trpt->bup.ovals[26];
		now.light_enabled[ Index(((8*4)+3), 40) ] = trpt->bup.ovals[25];
		now.light_enabled[ Index(((8*4)+0), 40) ] = trpt->bup.ovals[24];
		now.light_enabled[ Index(((7*4)+3), 40) ] = trpt->bup.ovals[23];
		now.light_enabled[ Index(((7*4)+1), 40) ] = trpt->bup.ovals[22];
		now.light_enabled[ Index(((7*4)+0), 40) ] = trpt->bup.ovals[21];
		now.light_enabled[ Index(((6*4)+1), 40) ] = trpt->bup.ovals[20];
		now.light_enabled[ Index(((6*4)+0), 40) ] = trpt->bup.ovals[19];
		now.light_enabled[ Index(((5*4)+3), 40) ] = trpt->bup.ovals[18];
		now.light_enabled[ Index(((5*4)+2), 40) ] = trpt->bup.ovals[17];
		now.light_enabled[ Index(((5*4)+0), 40) ] = trpt->bup.ovals[16];
		now.light_enabled[ Index(((4*4)+3), 40) ] = trpt->bup.ovals[15];
		now.light_enabled[ Index(((4*4)+2), 40) ] = trpt->bup.ovals[14];
		now.light_enabled[ Index(((4*4)+1), 40) ] = trpt->bup.ovals[13];
		now.light_enabled[ Index(((4*4)+0), 40) ] = trpt->bup.ovals[12];
		now.light_enabled[ Index(((3*4)+2), 40) ] = trpt->bup.ovals[11];
		now.light_enabled[ Index(((3*4)+1), 40) ] = trpt->bup.ovals[10];
		now.light_enabled[ Index(((3*4)+0), 40) ] = trpt->bup.ovals[9];
		now.light_enabled[ Index(((2*4)+3), 40) ] = trpt->bup.ovals[8];
		now.light_enabled[ Index(((2*4)+2), 40) ] = trpt->bup.ovals[7];
		now.light_enabled[ Index(((1*4)+3), 40) ] = trpt->bup.ovals[6];
		now.light_enabled[ Index(((1*4)+2), 40) ] = trpt->bup.ovals[5];
		now.light_enabled[ Index(((1*4)+1), 40) ] = trpt->bup.ovals[4];
		now.light_enabled[ Index(((0*4)+3), 40) ] = trpt->bup.ovals[3];
		now.light_enabled[ Index(((0*4)+2), 40) ] = trpt->bup.ovals[2];
		now.light_enabled[ Index(((0*4)+1), 40) ] = trpt->bup.ovals[1];
	/* 0 */	((P2 *)_this)->i = trpt->bup.ovals[0];
		;
		;
		ungrab_ints(trpt->bup.ovals, 38);
		goto R999;

	case 26: // STATE 46
		;
		((P2 *)_this)->i = trpt->bup.ovals[36];
		now.light_green[9] = trpt->bup.ovals[35];
		now.light_green[8] = trpt->bup.ovals[34];
		now.light_green[7] = trpt->bup.ovals[33];
		now.light_green[6] = trpt->bup.ovals[32];
		now.light_green[5] = trpt->bup.ovals[31];
		now.light_green[4] = trpt->bup.ovals[30];
		now.light_green[3] = trpt->bup.ovals[29];
		now.light_green[2] = trpt->bup.ovals[28];
		now.light_green[1] = trpt->bup.ovals[27];
		now.light_green[0] = trpt->bup.ovals[26];
		now.light_enabled[ Index(((9*4)+1), 40) ] = trpt->bup.ovals[25];
		now.light_enabled[ Index(((8*4)+3), 40) ] = trpt->bup.ovals[24];
		now.light_enabled[ Index(((8*4)+0), 40) ] = trpt->bup.ovals[23];
		now.light_enabled[ Index(((7*4)+3), 40) ] = trpt->bup.ovals[22];
		now.light_enabled[ Index(((7*4)+1), 40) ] = trpt->bup.ovals[21];
		now.light_enabled[ Index(((7*4)+0), 40) ] = trpt->bup.ovals[20];
		now.light_enabled[ Index(((6*4)+1), 40) ] = trpt->bup.ovals[19];
		now.light_enabled[ Index(((6*4)+0), 40) ] = trpt->bup.ovals[18];
		now.light_enabled[ Index(((5*4)+3), 40) ] = trpt->bup.ovals[17];
		now.light_enabled[ Index(((5*4)+2), 40) ] = trpt->bup.ovals[16];
		now.light_enabled[ Index(((5*4)+0), 40) ] = trpt->bup.ovals[15];
		now.light_enabled[ Index(((4*4)+3), 40) ] = trpt->bup.ovals[14];
		now.light_enabled[ Index(((4*4)+2), 40) ] = trpt->bup.ovals[13];
		now.light_enabled[ Index(((4*4)+1), 40) ] = trpt->bup.ovals[12];
		now.light_enabled[ Index(((4*4)+0), 40) ] = trpt->bup.ovals[11];
		now.light_enabled[ Index(((3*4)+2), 40) ] = trpt->bup.ovals[10];
		now.light_enabled[ Index(((3*4)+1), 40) ] = trpt->bup.ovals[9];
		now.light_enabled[ Index(((3*4)+0), 40) ] = trpt->bup.ovals[8];
		now.light_enabled[ Index(((2*4)+3), 40) ] = trpt->bup.ovals[7];
		now.light_enabled[ Index(((2*4)+2), 40) ] = trpt->bup.ovals[6];
		now.light_enabled[ Index(((1*4)+3), 40) ] = trpt->bup.ovals[5];
		now.light_enabled[ Index(((1*4)+2), 40) ] = trpt->bup.ovals[4];
		now.light_enabled[ Index(((1*4)+1), 40) ] = trpt->bup.ovals[3];
		now.light_enabled[ Index(((0*4)+3), 40) ] = trpt->bup.ovals[2];
		now.light_enabled[ Index(((0*4)+2), 40) ] = trpt->bup.ovals[1];
		now.light_enabled[ Index(((0*4)+1), 40) ] = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 37);
		goto R999;

	case 27: // STATE 49
		;
		((P2 *)_this)->i = trpt->bup.ovals[1];
		now.red_streak[ Index(((P2 *)_this)->i, 40) ] = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;

	case 28: // STATE 83
		;
		now.model_initialized = trpt->bup.ovals[29];
		now.sq_a_forbidden[1] = trpt->bup.ovals[28];
		now.returned_A[1] = trpt->bup.ovals[27];
		now.visited_D[1] = trpt->bup.ovals[26];
		now.visited_C[1] = trpt->bup.ovals[25];
		now.visited_B[1] = trpt->bup.ovals[24];
		now.veh_dest_idx[1] = trpt->bup.ovals[23];
		now.veh_dest[1] = trpt->bup.ovals[22];
		now.veh_heading[1] = trpt->bup.ovals[21];
		now.veh_node[1] = trpt->bup.ovals[20];
		now.veh_mode[1] = trpt->bup.ovals[19];
		now.sq_a_forbidden[0] = trpt->bup.ovals[18];
		now.returned_A[0] = trpt->bup.ovals[17];
		now.visited_D[0] = trpt->bup.ovals[16];
		now.visited_C[0] = trpt->bup.ovals[15];
		now.visited_B[0] = trpt->bup.ovals[14];
		now.veh_dest_idx[0] = trpt->bup.ovals[13];
		now.veh_dest[0] = trpt->bup.ovals[12];
		now.veh_heading[0] = trpt->bup.ovals[11];
		now.veh_node[0] = trpt->bup.ovals[10];
		now.veh_mode[0] = trpt->bup.ovals[9];
		now.tour_stops[ Index(((1*4)+3), 8) ] = trpt->bup.ovals[8];
		now.tour_stops[ Index(((1*4)+2), 8) ] = trpt->bup.ovals[7];
		now.tour_stops[ Index(((1*4)+1), 8) ] = trpt->bup.ovals[6];
		now.tour_stops[ Index(((1*4)+0), 8) ] = trpt->bup.ovals[5];
		now.tour_stops[ Index(((0*4)+3), 8) ] = trpt->bup.ovals[4];
		now.tour_stops[ Index(((0*4)+2), 8) ] = trpt->bup.ovals[3];
		now.tour_stops[ Index(((0*4)+1), 8) ] = trpt->bup.ovals[2];
		now.tour_stops[ Index(((0*4)+0), 8) ] = trpt->bup.ovals[1];
	/* 0 */	((P2 *)_this)->i = trpt->bup.ovals[0];
		;
		;
		ungrab_ints(trpt->bup.ovals, 30);
		goto R999;

	case 29: // STATE 83
		;
		now.model_initialized = trpt->bup.ovals[28];
		now.sq_a_forbidden[1] = trpt->bup.ovals[27];
		now.returned_A[1] = trpt->bup.ovals[26];
		now.visited_D[1] = trpt->bup.ovals[25];
		now.visited_C[1] = trpt->bup.ovals[24];
		now.visited_B[1] = trpt->bup.ovals[23];
		now.veh_dest_idx[1] = trpt->bup.ovals[22];
		now.veh_dest[1] = trpt->bup.ovals[21];
		now.veh_heading[1] = trpt->bup.ovals[20];
		now.veh_node[1] = trpt->bup.ovals[19];
		now.veh_mode[1] = trpt->bup.ovals[18];
		now.sq_a_forbidden[0] = trpt->bup.ovals[17];
		now.returned_A[0] = trpt->bup.ovals[16];
		now.visited_D[0] = trpt->bup.ovals[15];
		now.visited_C[0] = trpt->bup.ovals[14];
		now.visited_B[0] = trpt->bup.ovals[13];
		now.veh_dest_idx[0] = trpt->bup.ovals[12];
		now.veh_dest[0] = trpt->bup.ovals[11];
		now.veh_heading[0] = trpt->bup.ovals[10];
		now.veh_node[0] = trpt->bup.ovals[9];
		now.veh_mode[0] = trpt->bup.ovals[8];
		now.tour_stops[ Index(((1*4)+3), 8) ] = trpt->bup.ovals[7];
		now.tour_stops[ Index(((1*4)+2), 8) ] = trpt->bup.ovals[6];
		now.tour_stops[ Index(((1*4)+1), 8) ] = trpt->bup.ovals[5];
		now.tour_stops[ Index(((1*4)+0), 8) ] = trpt->bup.ovals[4];
		now.tour_stops[ Index(((0*4)+3), 8) ] = trpt->bup.ovals[3];
		now.tour_stops[ Index(((0*4)+2), 8) ] = trpt->bup.ovals[2];
		now.tour_stops[ Index(((0*4)+1), 8) ] = trpt->bup.ovals[1];
		now.tour_stops[ Index(((0*4)+0), 8) ] = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 29);
		goto R999;

	case 30: // STATE 85
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 31: // STATE 86
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 32: // STATE 87
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;
;
		;
		
	case 34: // STATE 89
		;
		all_tours_done = trpt->bup.oval;
		;
		goto R999;

	case 35: // STATE 91
		;
	/* 0 */	((P2 *)_this)->tick_count = trpt->bup.oval;
		;
		;
		goto R999;
	case 36: // STATE 106
		sv_restor();
		goto R999;

	case 37: // STATE 107
		;
		_m = unsend(now.tick_infra);
		;
		goto R999;

	case 38: // STATE 108
		;
	/* 0 */	((P2 *)_this)->dummy = trpt->bup.ovals[1];
		XX = 1;
		unrecv(now.done_infra, XX-1, 0, ((int)((P2 *)_this)->dummy), 1);
		((P2 *)_this)->dummy = trpt->bup.ovals[0];
		;
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;

	case 39: // STATE 109
		;
		_m = unsend(now.tick_vehicle[0]);
		;
		goto R999;

	case 40: // STATE 110
		;
		_m = unsend(now.tick_vehicle[1]);
		;
		goto R999;

	case 41: // STATE 111
		;
	/* 0 */	((P2 *)_this)->dummy = trpt->bup.ovals[1];
		XX = 1;
		unrecv(now.done_vehicle[0], XX-1, 0, ((int)((P2 *)_this)->dummy), 1);
		((P2 *)_this)->dummy = trpt->bup.ovals[0];
		;
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;

	case 42: // STATE 112
		;
	/* 0 */	((P2 *)_this)->dummy = trpt->bup.ovals[1];
		XX = 1;
		unrecv(now.done_vehicle[1], XX-1, 0, ((int)((P2 *)_this)->dummy), 1);
		((P2 *)_this)->dummy = trpt->bup.ovals[0];
		;
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;
	case 43: // STATE 338
		sv_restor();
		goto R999;
;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		;
		
	case 67: // STATE 362
		;
		all_tours_done = trpt->bup.oval;
		;
		goto R999;

	case 68: // STATE 367
		;
		((P2 *)_this)->tick_count = trpt->bup.oval;
		;
		goto R999;

	case 69: // STATE 367
		;
		((P2 *)_this)->tick_count = trpt->bup.oval;
		;
		goto R999;

	case 70: // STATE 371
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC VehicleFSM */

	case 71: // STATE 1
		;
	/* 0 */	((P1 *)_this)->dummy = trpt->bup.ovals[1];
		XX = 1;
		unrecv(now.tick_vehicle[ Index(((int)((P1 *)_this)->vid), 2) ], XX-1, 0, ((int)((P1 *)_this)->dummy), 1);
		((P1 *)_this)->dummy = trpt->bup.ovals[0];
		;
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;
	case 72: // STATE 352
		sv_restor();
		goto R999;

	case 73: // STATE 353
		;
		_m = unsend(now.done_vehicle[ Index(((int)((P1 *)_this)->vid), 2) ]);
		;
		goto R999;

	case 74: // STATE 357
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC InfraFSM */

	case 75: // STATE 1
		;
	/* 0 */	((P0 *)_this)->dummy = trpt->bup.ovals[1];
		XX = 1;
		unrecv(now.tick_infra, XX-1, 0, ((int)((P0 *)_this)->dummy), 1);
		((P0 *)_this)->dummy = trpt->bup.ovals[0];
		;
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;
	case 76: // STATE 213
		sv_restor();
		goto R999;

	case 77: // STATE 214
		;
		((P0 *)_this)->nid2 = trpt->bup.oval;
		;
		goto R999;

	case 78: // STATE 217
		;
		((P0 *)_this)->d2 = trpt->bup.ovals[1];
		((P0 *)_this)->gc = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;
;
		;
		;
		;
		
	case 81: // STATE 225
		;
		((P0 *)_this)->d2 = trpt->bup.ovals[1];
		((P0 *)_this)->gc = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;

	case 82: // STATE 225
		;
		((P0 *)_this)->d2 = trpt->bup.oval;
		;
		goto R999;

	case 83: // STATE 225
		;
		((P0 *)_this)->d2 = trpt->bup.oval;
		;
		goto R999;

	case 84: // STATE 232
		;
		((P0 *)_this)->nid2 = trpt->bup.ovals[1];
	/* 0 */	((P0 *)_this)->d2 = trpt->bup.ovals[0];
		;
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;

	case 85: // STATE 232
		;
		((P0 *)_this)->nid2 = trpt->bup.oval;
		;
		goto R999;

	case 86: // STATE 233
		;
	/* 0 */	((P0 *)_this)->nid2 = trpt->bup.oval;
		;
		;
		goto R999;

	case 87: // STATE 238
		;
		_m = unsend(now.done_infra);
		;
		goto R999;

	case 88: // STATE 242
		;
		p_restor(II);
		;
		;
		goto R999;
	}

