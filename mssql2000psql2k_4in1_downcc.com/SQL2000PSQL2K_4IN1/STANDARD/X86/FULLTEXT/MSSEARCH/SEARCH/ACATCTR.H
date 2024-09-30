//+---------------------------------------------------------------------------
//
//  Microsoft Search
//  Copyright (C) Microsoft Corporation, 1996 - 1999
//
//  File:       acatctr.h
//
//  Contents:   
//      Counter definitions for the autocat objects
//
//  Classes:    
//
//  Functions:  
//
//  History:     01-26-99        micahk          performance counters
//
//----------------------------------------------------------------------------

//
// Autocat LEARN object
//

#define OBJECT_LEARN                        0

#define COUNTER_LEARN_DOCUMENTS             2
#define COUNTER_LEARN_DOCUMENTS_PER_SECOND  4
#define COUNTER_LEARN_EXAMPLES              6
#define COUNTER_LEARN_CATEGORIES            8
#define COUNTER_LEARN_KEYWORDS              10

//
// Autocat SCORE object
//

#define OBJECT_SCORE                        12

#define COUNTER_SCORE_DOCUMENTS             14
#define COUNTER_SCORE_DOCUMENTS_PER_SECOND  16
#define COUNTER_SCORE_SCORED_DOCUMENTS      18
#define COUNTER_SCORE_UNSCORED_DOCUMENTS    20
#define COUNTER_SCORE_MANUAL_DOCUMENTS		22
#define COUNTER_SCORE_MANUAL_AND_AUTOCAT_DOCUMENTS	24
#define COUNTER_SCORE_ACCURATE_DOCUMENTS	26
