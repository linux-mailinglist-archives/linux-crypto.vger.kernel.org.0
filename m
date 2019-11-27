Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6F3110C0A6
	for <lists+linux-crypto@lfdr.de>; Thu, 28 Nov 2019 00:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfK0Xgz (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 27 Nov 2019 18:36:55 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:54530 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbfK0Xgz (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 27 Nov 2019 18:36:55 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xARNTdKB057274;
        Wed, 27 Nov 2019 23:36:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=Z0br7yFxus9V+xguTr7W8maMYEonihMlkEnz4VRBrDc=;
 b=LzCx9LjDFZaEnOjdab7ivaiyosB8LruZ84rZRWt2JY2amEh6icHfZjGvYN2xAPi+YUPj
 SWbbrNGtuYCrcTW/BTbPfP4Cxk8QiyGP3EKeDB+qgFa1mUCsCAlL+g9vB0LC4Uj77FWk
 7QJxgt4HScWbJfh4Iox6XySos9ePnfOaQSFyzE8RL52WpKk1V+WRxoYCIZ8wuD9tJpdB
 5OI6p+Px/6ZAlil/+sDoxGtYGdqyCPa4q3pHSm0IrNH9Lijl9gdGEx4SBEXn2GSJhJCt
 pOcowdMdzap1BlzG5WPSE8vxKNPM2avA8vpdUbzv69BG8FdKeV7DWgqyX6bfW7b+GMdk Hw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2wevqqge7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Nov 2019 23:36:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xARNYZB5015562;
        Wed, 27 Nov 2019 23:36:35 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2wh0rn2a4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Nov 2019 23:36:35 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xARNaXJb013656;
        Wed, 27 Nov 2019 23:36:33 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 Nov 2019 15:36:32 -0800
Date:   Wed, 27 Nov 2019 18:36:40 -0500
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] padata: Remove broken queue flushing
Message-ID: <20191127233640.kl5g2bpmg2hvlkz4@ca-dmjordan1.us.oracle.com>
References: <20191119051731.yev6dcsp2znjaagz@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119051731.yev6dcsp2znjaagz@gondor.apana.org.au>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9454 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911270188
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9454 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911270188
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Nov 19, 2019 at 01:17:31PM +0800, Herbert Xu wrote:
> The function padata_flush_queues is fundamentally broken because
> it cannot force padata users to complete the request that is
> underway.  IOW padata has to passively wait for the completion
> of any outstanding work.
> 
> As it stands flushing is used in two places.  Its use in padata_stop
> is simply unnecessary because nothing depends on the queues to
> be flushed afterwards.
> 
> The other use in padata_replace is more substantial as we depend
> on it to free the old pd structure.  This patch instead uses the
> pd->refcnt to dynamically free the pd structure once all requests
> are complete.
> 
> Fixes: 2b73b07ab8a4 ("padata: Flush the padata queues actively")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
