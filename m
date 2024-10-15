Return-Path: <linux-crypto+bounces-7313-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAEE99E56A
	for <lists+linux-crypto@lfdr.de>; Tue, 15 Oct 2024 13:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85F8EB232BA
	for <lists+linux-crypto@lfdr.de>; Tue, 15 Oct 2024 11:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397821D1F7F;
	Tue, 15 Oct 2024 11:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="edjaCSrG"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761C7189BB2;
	Tue, 15 Oct 2024 11:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728991166; cv=none; b=rfsWCo+SnPkSgvDnPKCcWVZJsxsY+hv1nd/577s1JFvQJ/CorPEZVl2M1IVWO0PL9kl2rIQ5pfo2VDv3U/2/3Uzg9Ce9OYCEhjMhmlqlf9mlsJ7H2F5A/OHQMO5OFj7or80kX3gUMKTzJfx93TDajpJqNomGeH7WhT/7f4hcT/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728991166; c=relaxed/simple;
	bh=n8pKS2FYlNvODSKTpt3Q5i1QcUBZTc/iMW0nOtmXnxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hyE7i8ZbUY1sgVe4KwX/+lWkpxJTSoG0P37CbYWrEhc60GisPJK/AXQ2DKMgG/v89kzZhGJRR3Bi0kOyXqgzSoTPIrpMIxXt/P4qWjLPaZaCLNjBQasmdZWs0tBhyWI2CXNCE5Qg77F7QmaaaXw1TwmtIIbR6ToFT5LCl/OrGPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=edjaCSrG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49F8PH4X023708;
	Tue, 15 Oct 2024 11:19:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=dqT2a81M4rhuVSAu7Pxl90+Rd3G4TA
	AyQ30vfsM+Z8c=; b=edjaCSrGojKuBo6dnqK7/pXemOZTGZpW0eKQemw9PbfhM9
	cotuXaXUQJlbinPbvRH71SKIL3MR67tvvcNr1zhX5FQAZp2bqHadL63pPIh/BD3x
	jeIJMrHWtvUN2q/DrXDSEj+k5GA+Q0ozPyN8Dai3zWwHZkAemR3Ad9Kh0mwpK/i4
	d4zpqaGts4sRGqiXHcdmeF0WfTDkxKkDD9XIVjldfHMdYtERspe3nmzzduozAhKv
	g+WQLTBxtOWFnJ4cTlkZRGZjeDn5Pb7v56rMKRvEYiBiAbiPWcFRd1r7j5zeBoTo
	T1nD+irpeHYRzVhGmRKis1i0DYAI0/q17aFExTpw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429mv4ruan-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 11:19:10 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49FBJ99u022186;
	Tue, 15 Oct 2024 11:19:09 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429mv4ruag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 11:19:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49FAqvZp002426;
	Tue, 15 Oct 2024 11:19:08 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284emkfsc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 11:19:08 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49FBJ44N52691326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 11:19:04 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 84CF12004B;
	Tue, 15 Oct 2024 11:19:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1D8F20043;
	Tue, 15 Oct 2024 11:18:58 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.39.24.36])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 15 Oct 2024 11:18:58 +0000 (GMT)
Date: Tue, 15 Oct 2024 16:48:53 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: drivers/nx: Invalid wait context issue when rebooting
Message-ID: <Zw5PnZEXcMPJdwwy@linux.ibm.com>
References: <ZwjjXJ5UtZ28FH6s@linux.ibm.com>
 <87wmif53iw.fsf@mail.lhotse>
 <ZwkbOJN5Jmjy_wkJ@linux.ibm.com>
 <87a5f6zxbn.fsf@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5f6zxbn.fsf@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2GMpzWhjUOukLK5eUVm_v-I1enkD2lMB
X-Proofpoint-ORIG-GUID: Q2drQnzHCd9e9bf6i_OihRd7djsPDkxl
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 mlxscore=0 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 malwarescore=0 mlxlogscore=710
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150072

On Mon, Oct 14, 2024 at 05:54:44PM +0530, Ritesh Harjani wrote:
> Vishal Chourasia <vishalc@linux.ibm.com> writes:
> 
> > On Fri, Oct 11, 2024 at 09:37:27PM +1100, Michael Ellerman wrote:
> >> 
> >> I don't see why of_reconfig_notifier_unregister() needs to be called
> >> with the devdata_mutext held, but I haven't looked that closely at it.
> >> 
> >> So the change below might work.
> >> 
> >> cheers
> >> 
> >> diff --git a/drivers/crypto/nx/nx-common-pseries.c b/drivers/crypto/nx/nx-common-pseries.c
> >> index 35f2d0d8507e..a2050c5fb11d 100644
> >> --- a/drivers/crypto/nx/nx-common-pseries.c
> >> +++ b/drivers/crypto/nx/nx-common-pseries.c
> >> @@ -1122,10 +1122,11 @@ static void nx842_remove(struct vio_dev *viodev)
> >>  
> >>  	crypto_unregister_alg(&nx842_pseries_alg);
> >>  
> >> +	of_reconfig_notifier_unregister(&nx842_of_nb);
> >> +
> >>  	spin_lock_irqsave(&devdata_mutex, flags);
> >>  	old_devdata = rcu_dereference_check(devdata,
> >>  			lockdep_is_held(&devdata_mutex));
> >> -	of_reconfig_notifier_unregister(&nx842_of_nb);
> >>  	RCU_INIT_POINTER(devdata, NULL);
> >>  	spin_unlock_irqrestore(&devdata_mutex, flags);
> >>  	synchronize_rcu();
> >> 
> > With above changes, I see another similar bug, but what's strange is
> > swapper does not hold any lock and still this bug is being triggered
> 
> Looking at the below stack, it looks like you discovered a new problem
> after the above problem was fixed with the above changes.
> (So maybe you could submit this fix along with [1])
Sure, Ritesh. I have posted another version with the fix.
https://lore.kernel.org/all/20241015105551.1817348-2-vishalc@linux.ibm.com

> Also looking at the history of changes, seems the above problem always
> existed. Not sure why it wasn't caught earlier then?
> 
> [1]: https://lore.kernel.org/linuxppc-dev/ZwyqD-w5hEhrnqTB@linux.ibm.com/T/#u
> 
> I am not much aware of the below code paths. Nor it is evident from the
> stack on why "Invalid wait context". Maybe you can give git bisect a try
> for below issue (or can also wait for someone to comment on below stack).
> (But you might have to keep the nx-common-pseries driver disabled for git bisect to work). 
I will see if I can find a good commit and then carry out the bisect.
> 
> >
> > =============================
> > [ BUG: Invalid wait context ]
> > 6.12.0-rc2-fix-invalid-wait-context-00222-g7d2910da7039-dirty #84 Not tainted
> > -----------------------------
> > swapper/2/0 is trying to lock:
> > c000000004062128 (&xibm->lock){....}-{3:3}, at: xive_spapr_put_ipi+0xb8/0x120
> > other info that might help us debug this:
> > context-{2:2}
> > no locks held by swapper/2/0.
> > stack backtrace:
> > CPU: 2 UID: 0 PID: 0 Comm: swapper/2 Not tainted 6.12.0-rc2-fix-invalid-wait-context-00222-g7d2910da7039-dirty #84
> > Hardware name: IBM,9080-HEX POWER10 (architected) 0x800200 0xf000006 of:IBM,FW1060.00 (NH1060_012) hv:phyp pSeries
> > Call Trace:
> > [c000000004ac3420] [c00000000130d2e4] dump_stack_lvl+0xc8/0x130 (unreliable)
> > [c000000004ac3460] [c000000000312ca8] __lock_acquire+0xb68/0xf00
> > [c000000004ac3570] [c000000000313130] lock_acquire.part.0+0xf0/0x2a0
> > [c000000004ac3690] [c0000000013955b8] _raw_spin_lock_irqsave+0x78/0x130
> > kexec: waiting for cpu 2 (physical 2) to enter 2 state
> > [c000000004ac36d0] [c000000000194798] xive_spapr_put_ipi+0xb8/0x120
> > [c000000004ac3710] [c000000001383728] xive_cleanup_cpu_ipi+0xc8/0xf0
> > [c000000004ac3750] [c0000000013837f4] xive_teardown_cpu+0xa4/0x100
> > [c000000004ac3780] [c0000000001d2cc4] pseries_kexec_cpu_down+0x54/0x1e0
> > [c000000004ac3800] [c000000000213674] kexec_smp_down+0x124/0x1f0
> > [c000000004ac3890] [c0000000003c9ddc] __flush_smp_call_function_queue+0x28c/0xad0
> > [c000000004ac3950] [c00000000005fb64] smp_ipi_demux_relaxed+0xe4/0xf0
> > [c000000004ac3990] [c0000000000593d8] doorbell_exception+0x108/0x2f0
> > [c000000004ac3a20] [c00000000000a26c] doorbell_super_common_virt+0x28c/0x290
> > --- interrupt: a00 at plpar_hcall_norets_notrace+0x18/0x2c
> > NIP:  c0000000001bee18 LR: c0000000013867a8 CTR: 0000000000000000
> > REGS: c000000004ac3a50 TRAP: 0a00   Not tainted  (6.12.0-rc2-fix-invalid-wait-context-00222-g7d2910da7039-dirty)
> > MSR:  800000000280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 22000242  XER: 00000001
> > CFAR: 0000000000000000 IRQMASK: 0
> > GPR00: 0000000000000000 c000000004ac3cf0 c000000001e37600 0000000000000000
> > GPR04: 0000000000000000 0000000000000000 0001dc4f97750361 0000000000010000
> > GPR08: 00000000000000c0 0000000000000080 0001dc4f97750554 0000000000000080
> > GPR12: 0000000000000000 c0000007fffee480 0000000000000000 0000000000000000
> > GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> > GPR20: 0000000000000000 c000000002ebf778 0000000000000000 00000043a215d824
> > GPR24: 0000000000000000 c000000000ec0f80 c000000002ebf778 0000000000000000
> > GPR28: 0000000000000000 0000000000000001 c0000000021a2300 c0000000021a2308
> > NIP [c0000000001bee18] plpar_hcall_norets_notrace+0x18/0x2c
> > LR [c0000000013867a8] check_and_cede_processor+0x48/0x80
> > --- interrupt: a00
> > [c000000004ac3cf0] [0000000000982538] 0x982538 (unreliable)
> > [c000000004ac3d50] [c000000001386874] dedicated_cede_loop+0x94/0x1a0
> > [c000000004ac3da0] [c00000000138584c] cpuidle_enter_state+0x10c/0x8a8
> > [c000000004ac3e50] [c000000000ec0f80] cpuidle_enter+0x50/0x80
> > [c000000004ac3e90] [c0000000002ba9c8] call_cpuidle+0x48/0xa0
> > [c000000004ac3eb0] [c0000000002cec54] cpuidle_idle_call+0x164/0x250
> > [c000000004ac3f00] [c0000000002cee74] do_idle+0x134/0x1d0
> > [c000000004ac3f50] [c0000000002cf34c] cpu_startup_entry+0x4c/0x50
> > [c000000004ac3f80] [c0000000000607d0] start_secondary+0x280/0x2b0
> > [c000000004ac3fe0] [c00000000000e058] start_secondary_prolog+0x10/0x14
> 
> -ritesh

