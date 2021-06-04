Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327F639AF4E
	for <lists+linux-crypto@lfdr.de>; Fri,  4 Jun 2021 03:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhFDBFD (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 3 Jun 2021 21:05:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48308 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229576AbhFDBFD (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 3 Jun 2021 21:05:03 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1540XfXx155451;
        Thu, 3 Jun 2021 21:03:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Bg64x1LwGm2bJ0pNp/NXlF0U0+7BtRh5DIhLzV45chs=;
 b=EnekVh4xSE9yKmoWSVBw4ZX/xK87i/9OOxKX/19SdwI+XiWDz9LxOwrGftnFfteqDx0C
 U63gHm4dqHh+WGfMq9hrahguRtofKpJz88q4TUehw7Q1wHWB+ERgQXTVc3okJsDJIBX6
 NaBTyp3HKnHSfRL+BIgSb9gKk4Hd8mJBZjvm3V0NIPjhNzL4zmkqRZS7CsV8ZwXkONBX
 ic+qGF0qlUjYd/7g/aA7y3JdT3RnxX+mITg3DJFc2s7zR9zmzHzkwLVa1cKT+cHIJoVm
 uHIsONyi+mqYNsuGuXLSDOjxv/TsBD6ry5W7mLc5RO7z9d3k1BUdPE49X6FLoYqTx05A 4w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38y6v03ycd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Jun 2021 21:03:03 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 154118uL039708;
        Thu, 3 Jun 2021 21:03:03 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38y6v03yc0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Jun 2021 21:03:03 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1540vG2f002000;
        Fri, 4 Jun 2021 01:03:02 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma04dal.us.ibm.com with ESMTP id 38ud8af5qv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Jun 2021 01:03:02 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 154131mj19333446
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Jun 2021 01:03:01 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DCC79AE062;
        Fri,  4 Jun 2021 01:03:01 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC1DDAE060;
        Fri,  4 Jun 2021 01:03:00 +0000 (GMT)
Received: from sig-9-77-136-17.ibm.com (unknown [9.77.136.17])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  4 Jun 2021 01:03:00 +0000 (GMT)
Message-ID: <340144138c53ae83588edcf0b4a5ae1880a01cd0.camel@linux.ibm.com>
Subject: Re: [PATCH v4 16/16] crypto/nx: Add sysfs interface to export NX
 capabilities
From:   Haren Myneni <haren@linux.ibm.com>
To:     Nicholas Piggin <npiggin@gmail.com>, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au
Cc:     haren@us.ibm.com, hbabu@us.ibm.com
Date:   Thu, 03 Jun 2021 18:02:58 -0700
In-Reply-To: <1622696109.949hlg4tnq.astroid@bobo.none>
References: <8d219c0816133a8643d650709066cf04c9c77322.camel@linux.ibm.com>
         <35bca44c5a8af7bdffbe03b22fd82713bced8d0e.camel@linux.ibm.com>
         <1622696109.949hlg4tnq.astroid@bobo.none>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pXglEwrFhaFXkl-jxPOAGyg-iYP2wJZe
X-Proofpoint-ORIG-GUID: AYYWK_395X9oToEf5P4r6QV8I2GhlSXI
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-03_15:2021-06-03,2021-06-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 clxscore=1015 mlxscore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106040000
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, 2021-06-03 at 14:57 +1000, Nicholas Piggin wrote:
> Excerpts from Haren Myneni's message of May 21, 2021 7:42 pm:
> > Changes to export the following NXGZIP capabilities through sysfs:
> > 
> > /sys/devices/vio/ibm,compression-v1/NxGzCaps:
> 
> Where's the horrible camel case name coming from? PowerVM?

Yes, pHyp provides the capabalities string.

Capability Description Descriptor Value Descriptor ascii Value
Overall NX Capabilities 0x4E78204361707320 “Nx Caps ”
NX GZIP Capabilities 0x4E78477A43617073 “NxGzCaps”


> 
> Thanks,
> Nick
> 
> > min_compress_len  /*Recommended minimum compress length in bytes*/
> > min_decompress_len /*Recommended minimum decompress length in
> > bytes*/
> > req_max_processed_len /* Maximum number of bytes processed in one
> > 			request */
> > 
> > NX will return RMA_Reject if the request buffer size is greater
> > than req_max_processed_len.
> > 
> > Signed-off-by: Haren Myneni <haren@linux.ibm.com>
> > Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
> > ---
> >  drivers/crypto/nx/nx-common-pseries.c | 43
> > +++++++++++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> > 
> > diff --git a/drivers/crypto/nx/nx-common-pseries.c
> > b/drivers/crypto/nx/nx-common-pseries.c
> > index 4a7278464156..121718a337fd 100644
> > --- a/drivers/crypto/nx/nx-common-pseries.c
> > +++ b/drivers/crypto/nx/nx-common-pseries.c
> > @@ -968,6 +968,36 @@ static struct attribute_group
> > nx842_attribute_group = {
> >  	.attrs = nx842_sysfs_entries,
> >  };
> >  
> > +#define	nxct_caps_read(_name)					
> > 	\
> > +static ssize_t nxct_##_name##_show(struct device *dev,		
> > 	\
> > +			struct device_attribute *attr, char *buf)	\
> > +{									
> > \
> > +	return sprintf(buf, "%lld\n", nx_ct_caps._name);		\
> > +}
> > +
> > +#define NXCT_ATTR_RO(_name)					
> > 	\
> > +	nxct_caps_read(_name);						
> > \
> > +	static struct device_attribute dev_attr_##_name = __ATTR(_name,
> > 	\
> > +						0444,			
> > \
> > +						nxct_##_name##_show,	
> > \
> > +						NULL);
> > +
> > +NXCT_ATTR_RO(req_max_processed_len);
> > +NXCT_ATTR_RO(min_compress_len);
> > +NXCT_ATTR_RO(min_decompress_len);
> > +
> > +static struct attribute *nxct_caps_sysfs_entries[] = {
> > +	&dev_attr_req_max_processed_len.attr,
> > +	&dev_attr_min_compress_len.attr,
> > +	&dev_attr_min_decompress_len.attr,
> > +	NULL,
> > +};
> > +
> > +static struct attribute_group nxct_caps_attr_group = {
> > +	.name	=	nx_ct_caps.name,
> > +	.attrs	=	nxct_caps_sysfs_entries,
> > +};
> > +
> >  static struct nx842_driver nx842_pseries_driver = {
> >  	.name =		KBUILD_MODNAME,
> >  	.owner =	THIS_MODULE,
> > @@ -1057,6 +1087,16 @@ static int nx842_probe(struct vio_dev
> > *viodev,
> >  		goto error;
> >  	}
> >  
> > +	if (caps_feat) {
> > +		if (sysfs_create_group(&viodev->dev.kobj,
> > +					&nxct_caps_attr_group)) {
> > +			dev_err(&viodev->dev,
> > +				"Could not create sysfs NX capability
> > entries\n");
> > +			ret = -1;
> > +			goto error;
> > +		}
> > +	}
> > +
> >  	return 0;
> >  
> >  error_unlock:
> > @@ -1076,6 +1116,9 @@ static void nx842_remove(struct vio_dev
> > *viodev)
> >  	pr_info("Removing IBM Power 842 compression device\n");
> >  	sysfs_remove_group(&viodev->dev.kobj, &nx842_attribute_group);
> >  
> > +	if (caps_feat)
> > +		sysfs_remove_group(&viodev->dev.kobj,
> > &nxct_caps_attr_group);
> > +
> >  	crypto_unregister_alg(&nx842_pseries_alg);
> >  
> >  	spin_lock_irqsave(&devdata_mutex, flags);
> > -- 
> > 2.18.2
> > 
> > 
> > 

