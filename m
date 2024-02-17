Return-Path: <linux-crypto+bounces-2151-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B008590D3
	for <lists+linux-crypto@lfdr.de>; Sat, 17 Feb 2024 17:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30F462826A4
	for <lists+linux-crypto@lfdr.de>; Sat, 17 Feb 2024 16:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1802C7CF1F;
	Sat, 17 Feb 2024 16:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GBTXJGI1"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2717C6DB;
	Sat, 17 Feb 2024 16:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708186826; cv=fail; b=im3rFs9q//RbTs/vDorIF5x6vqT3Gi1gq9p+ES7mxxRjtzwjDHVTyM2tXqUiZX/bz/GAYdoNZOJIonj3uG8rCTDPGtc+tExMLm0LQqeyZWRfnT0X4DdcNXEnAQdYGFa11KgD+DMHekyhdEsbVolQBb6ouyNEdW+JLjbrCt1T7uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708186826; c=relaxed/simple;
	bh=e7+1bWiYZaejJKTdcJDhZphC0430UTxWUfdq26IItS4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KekPLDHeUmq7RA2FidhREdbPvLLgnBNcDulGB6n7VVMCkOLtZf8u4gcTGnFjjr78guhV+aWdL8s7xdKYtBVIqyc4d3CHpfmhShZCXJKyKypgJ0KkGvRlVUkIdcCb7B0Nsy2R325Nej+z9YFyZIX+M3LTT04Gtb/yINdmNt0ZdKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GBTXJGI1; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708186825; x=1739722825;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=e7+1bWiYZaejJKTdcJDhZphC0430UTxWUfdq26IItS4=;
  b=GBTXJGI15RIX7X6YfCE+DShLht9IS+JTnANweBZBNkUi/O74HlZRYtYJ
   pi+0WCPFj6CtckdXqfQaOF0ZYJZTKqxPKCHGsPBC+rMnsZF1ajrK/yUFK
   vjHNTXMNjkWzZOwEe17JPWVGyXcvmxMU77AhsgzjYPljMyrRmjiZKs79+
   tcd25QEmP8RGUUb0ZS95t4tTXFgYbHkxHuUmu5rdMNXVCBGRocw05+Cko
   wWiv6EanTTULJRQxmkiGahXWkKRCXPX220Gcl8SZ+hqfKl4fAFb2RMgnJ
   QY4O4R3PscKhygBrS834mGFV7JH7rH1wfo9joLyT1jkZNebi9trDSdnKt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="6110746"
X-IronPort-AV: E=Sophos;i="6.06,166,1705392000"; 
   d="scan'208";a="6110746"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2024 08:20:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,166,1705392000"; 
   d="scan'208";a="41590756"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Feb 2024 08:20:24 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 17 Feb 2024 08:20:23 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 17 Feb 2024 08:20:23 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 17 Feb 2024 08:20:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odY02tdV7pKlVpn4NyLhldj1TLuWAjt6ZkpFuA8ScAaS1qw0E35qvTg58GzfRME9qgp37iHKrnqQEmBjqBks3hr+XCGeKGQ+peRjnrp/n6PrRPTbIQwRIL3e9o8Z+ZdLibUVkepDp6ton0bUjms6RZ/ESqfI/wafy7tfnwzBruoKcuRuKfT5MJAKfC4UJhcS1uZLEde/yVFApMh8hjRBoyQE7psSS3kdrezM3ctIG0xcO9O4l7bpmgE8j5KQffMewgs9SdiJDLxKyOmFXGh6/EwVyhbNglrxadSrrAuYnKXPb+D9QByX6VAe+WJMpdfjX5On26K2cSbxLukUHL4RTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7+1bWiYZaejJKTdcJDhZphC0430UTxWUfdq26IItS4=;
 b=Yf0d6ijGQvyZ7b/W4VhWXOTGEvdyIRX2CeM3s+ehgF3EZn4VuRF7a+Pg+ha7wVb2KrPjN99To08CjfRJya1yg32xqmiEuyslmog2aZRD5xdI+6OT5egIIYNTpHXM1dcLBrT2+XclS7kZ18XlY4XcT4xrZgKf9Dp3/IWGZnTMH0ojxi4MOS9gN/MibPJdx7ht+H114JRYpVs8/5KpTxDhIu2Rmbt+TZ3n4aWBmtxlNUn4T4MwTQdPydZOUnKOzVu+4mybPCnLS8PCB34wT2JLtTM5tmoxnEjhd++IjuenvLFhyvYBSqzVhzn9vm4iF37+tQRzpoVnBw0syOIHwiqhwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5502.namprd11.prod.outlook.com (2603:10b6:5:39e::23)
 by PH7PR11MB6881.namprd11.prod.outlook.com (2603:10b6:510:200::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Sat, 17 Feb
 2024 16:20:20 +0000
Received: from DM4PR11MB5502.namprd11.prod.outlook.com
 ([fe80::502d:eb38:b486:eef0]) by DM4PR11MB5502.namprd11.prod.outlook.com
 ([fe80::502d:eb38:b486:eef0%4]) with mapi id 15.20.7292.026; Sat, 17 Feb 2024
 16:20:20 +0000
From: "Zeng, Xin" <xin.zeng@intel.com>
To: Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, qat-linux <qat-linux@intel.com>,
	"Cao, Yahui" <yahui.cao@intel.com>
Subject: RE: [PATCH 10/10] vfio/qat: Add vfio_pci driver for Intel QAT VF
 devices
Thread-Topic: [PATCH 10/10] vfio/qat: Add vfio_pci driver for Intel QAT VF
 devices
Thread-Index: AQHaVSVFJ9K0TVMQD0C9btTtb+JmirD9TRgAgAQ3vqCAAHLkgIAC42sAgAhyjxA=
Date: Sat, 17 Feb 2024 16:20:20 +0000
Message-ID: <DM4PR11MB550274B713F6AE416CDF7FDB88532@DM4PR11MB5502.namprd11.prod.outlook.com>
References: <20240201153337.4033490-1-xin.zeng@intel.com>
 <20240201153337.4033490-11-xin.zeng@intel.com>
 <20240206125500.GC10476@nvidia.com>
 <DM4PR11MB550222F7A5454DF9DBEE7FEC884B2@DM4PR11MB5502.namprd11.prod.outlook.com>
 <20240209121045.GP10476@nvidia.com>
 <e740d9ec-6783-4777-b984-98262566974c@nvidia.com>
In-Reply-To: <e740d9ec-6783-4777-b984-98262566974c@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5502:EE_|PH7PR11MB6881:EE_
x-ms-office365-filtering-correlation-id: 3628d90e-8821-4026-157e-08dc2fd45632
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XUyfLAuvp/rHhQTZDoWWlOgYsI81zNogU9IoNT62zzkFWZv+JpBIb6DxIGGojg2zCIqfZjjN0tCGEUOdTSoyW8Jb80VSQ6bb8EY84e8Swcp0028575ETlBOMgm1qeQtigXV8eq27YOzaDfg+k8x6/yXH29kOjXe8ApzVWT71Ovz/KAVDDSc0SkuSebmwq2zzYBixtAnLF8wpuIj06ploVCL95Nd9zMewFZNDbaHlmxutzQVhifJ1cNgBPlS13nEFzir6Ndm5mcA0Q6lPpNqZ6uy5ypYRv6R6ECm9adRuVA0ymLeQtnVGSMF/fa6v/QVGqlGbO8M3JyBpCAUd6gQ+G+qMFUt/vM1GXH5fUWT2ycc+05j0iZx9ky2C6KmudkF1UwT9spA4wB8ZKNX/LL3EYGRbKEA5rY4/yaqEgiBs+ha8nAtuqixUmhht+AlPH/F0M2axPi7ID4vkX8Ud1pNW5xmIytthxuXsVcj4uprPiWg4HzArWvAVvJHXYtPRzSvlER/Cv+kOf4b55mZ8ukqkEpQBtptRtuvrb+m7+A1FlDCGE/2Gbzp5mBUSbZCYL+B4lahRnU85uNO9dXjeoi7nnwC7h3/05fWa/+I4m74ZmsUyt5vhNmVFOXL8m/7Y09b5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5502.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(366004)(346002)(376002)(230922051799003)(230273577357003)(64100799003)(1800799012)(186009)(451199024)(66446008)(38070700009)(66476007)(52536014)(26005)(107886003)(83380400001)(41300700001)(76116006)(316002)(66946007)(8936002)(4326008)(64756008)(8676002)(66556008)(110136005)(6506007)(478600001)(71200400001)(7696005)(9686003)(53546011)(54906003)(122000001)(33656002)(82960400001)(86362001)(38100700002)(55016003)(5660300002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWlqWnlVUS9rd2xpZWFJUVRXSWIwSTVPVGQvWWZPN0RJeTRoaWh0K3dDMUM2?=
 =?utf-8?B?WXF6NlNIK3VucWlhZWtnOTBRemwzUkZQazRpOHQ1SDdVVVVKcTNyWUpmZjZn?=
 =?utf-8?B?V1B1TGkzTnBCK2NGR0t2elN5MzBXVEpsV0RWL0xiL2FWV0ZnZ0VuR3hQWkhp?=
 =?utf-8?B?ek1BWk5Ia2tLeEZVTjB3Qno3Ky9QaTVyTVEycG1tZTl3cFU4cE5NbTl5ekxQ?=
 =?utf-8?B?cTI0a0lHajVMZVVEei9uazNrQVhrS1p2YStCU0c3WG0yU2w2V1UrWVlOVG9U?=
 =?utf-8?B?cXAxZ3JkMjBkNjI4dmg3Y212MytBWGhXUExrUGRYRktnT1RJOEJXemNTeGQr?=
 =?utf-8?B?M05uVU13NnBKMmFMcVFMTmhQSFZlQk1wWnpXaktmWGZzbG1ValRLeW9qTVJL?=
 =?utf-8?B?dGc2KzRtMnRLSXpKaDZ4SFNpTVd4UkhaK05rT3BSM0d3MllBMlJ2aXpQUDlR?=
 =?utf-8?B?QUlqUHNBdTF3N3JBNXpObXFJQ0RjZVJWY1QxTDlhRVg0VktLOVFSV3BtdlYw?=
 =?utf-8?B?Tk1KalFJWkxVWklXNjZveHRDOUJZT0h2Mlo4ejNaNFhkck1jZE4wS3NNcDl4?=
 =?utf-8?B?bU5XSEZjNzNnTFV4cGNWVC9KL3ovRHE3S054a1VNZ0RuVjdBY2lQWnpSWHhF?=
 =?utf-8?B?MjBRcjFDSW1sajJqQ21laTVqZjN2Yyt6MUk0WTlNUmpqTUVFK3hteVV3MzRl?=
 =?utf-8?B?Sk9GNStOOFM0OTJrLzlYRm9ZaXFrM2lNQk9Wd2NLL1dJNGF6M1p4T2crMUk5?=
 =?utf-8?B?NmNYSUN6dk9JSTdFbGd4NDVuakxDajJBeFcwMjF3eUJKOU1mZFc4MjZQMUQ2?=
 =?utf-8?B?cUVDVFZGVy83L1BDa081cVhpYkxSWVZsdHVycVNnSkVhM0dnQ21vcU0xK0dx?=
 =?utf-8?B?bWQwVEZtZ2llWkc1SGMyVVVBd1lyMjl1bXluamc3V0o0ZW8rblE2TjZBWVFL?=
 =?utf-8?B?MkdHZXYvSVYvWGdaOCtuS3FMUERPOUpOcTAzV1hPRERXUU1Yb21aVHEzUmx5?=
 =?utf-8?B?blI2Q1pkZjRIVnVsQytPbno2OG9oUmxjQytVZWdpQmZoU1NsRCtmeFFpK28z?=
 =?utf-8?B?RkcwWXgybXgwVno5by9KNUZjeitnVFFIaFovTTQwMVMwUzg5N05qOXVKOThT?=
 =?utf-8?B?T2wrVWhrOWVqVElnSmJPbHNJcTlyeHJkcUJYQXoxYWtpQ1krandWODhCVXFM?=
 =?utf-8?B?Z2krK2tHOEd0T1Z3b2N3MzMyemFXNjhHSFUrbklCR0ppTzYxQTNtcnY4RVlS?=
 =?utf-8?B?Njk3N3VJa0hXMTh6YnFXV0pucUhYVkdZS3pkWjlEUUg1OUcvMFBQaWNTTExS?=
 =?utf-8?B?dTRrY1pLbiswVjNKbGJKa3RLUzZTVGtjZ3BFVzFtZEhQbTc1WW0wUTZwaFE1?=
 =?utf-8?B?SUhKWktNTmtSMVhIR1ZraHJJdGVORHA1amJ5bm9kSjIvbEFLVzZpY21jVXN4?=
 =?utf-8?B?YThxMDVBUmlwWnVWUXY5ci9LTEk3RHdqOUdlNjJNZVBXSXlTSU5kd2E3REdS?=
 =?utf-8?B?SmVpV3daaGdNWXAvVytTcWpJSmMxa3BKdThnU25tZDRGcWdjVkM3VEYvYTd0?=
 =?utf-8?B?bmhQS3MvS3c2NGRoSmlCQlpSVk1qY1YzazJqenoxRktQdVc0azlsRGN1eDlX?=
 =?utf-8?B?VzZ3WndSRmVWRTlZZ2FFNU5BcWJPSFBwT2dsZlVHbmVldFhlN0FZWWpzU2N0?=
 =?utf-8?B?bGRmUmkzOWUvdC9XM2JGNFNnVFMxcTB3KzJacTJGYUNINFAxbWJ1aUFzdkdP?=
 =?utf-8?B?RGhETk9HRXdsZTZORHIzY1F0WDFJV0l3NXFQV2NmL1BCeTdackVEUFh6aGhJ?=
 =?utf-8?B?dUNLWHNheHI4STgvbkNoYWh2QjRDWnhzZDVkRi9GUVhXREtReEl1UERxUzVJ?=
 =?utf-8?B?RnBRZEwzNmxnV0RkdDlvTk1oV1I4RjU3ak5RVFFxNzBwV0djdUdRQUhkUUlm?=
 =?utf-8?B?TVNvdThqUkRIcGhVbmxxNFprUGNvaDFVcW9EcEdUQ0dJK0ZQK05RR1BScDNV?=
 =?utf-8?B?NjNDdXJOR0tsRFZtY0dUL2xhOS9zL1pnV1J6QUtabk5zYU1tWTA1ZWo4Vkt2?=
 =?utf-8?B?T2FvVkdaSGJTajh5SDd5VFVzRjRoK0Z0YngyM2QxQ2taR2V5eHhXNkUxaHRQ?=
 =?utf-8?Q?//NQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3628d90e-8821-4026-157e-08dc2fd45632
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2024 16:20:20.5146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pasNlLPbH6/MC9yYKlreHyZQH1fbzoBglDw3FcCKJV1QYCrZ4FAz6fUp3Q3ygEXrR5awyCRYmOpm6cntiIf2UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6881
X-OriginatorOrg: intel.com

T24gU3VuZGF5LCBGZWJydWFyeSAxMSwgMjAyNCA0OjE3IFBNLCBZaXNoYWkgSGFkYXMgPHlpc2hh
aWhAbnZpZGlhLmNvbT4gd3JvdGU6DQo+ID4+Pj4gK3N0YXRpYyB2b2lkIHFhdF92Zl9wY2lfYWVy
X3Jlc2V0X2RvbmUoc3RydWN0IHBjaV9kZXYgKnBkZXYpDQo+ID4+Pj4gK3sNCj4gPj4+PiArCXN0
cnVjdCBxYXRfdmZfY29yZV9kZXZpY2UgKnFhdF92ZGV2ID0gcWF0X3ZmX2RydmRhdGEocGRldik7
DQo+ID4+Pj4gKw0KPiA+Pj4+ICsJaWYgKCFxYXRfdmRldi0+Y29yZV9kZXZpY2UudmRldi5taWdf
b3BzKQ0KPiA+Pj4+ICsJCXJldHVybjsNCj4gPj4+PiArDQo+ID4+Pj4gKwkvKg0KPiA+Pj4+ICsJ
ICogQXMgdGhlIGhpZ2hlciBWRklPIGxheWVycyBhcmUgaG9sZGluZyBsb2NrcyBhY3Jvc3MgcmVz
ZXQgYW5kIHVzaW5nDQo+ID4+Pj4gKwkgKiB0aG9zZSBzYW1lIGxvY2tzIHdpdGggdGhlIG1tX2xv
Y2sgd2UgbmVlZCB0byBwcmV2ZW50IEFCQkENCj4gPj4+IGRlYWRsb2NrDQo+ID4+Pj4gKwkgKiB3
aXRoIHRoZSBzdGF0ZV9tdXRleCBhbmQgbW1fbG9jay4NCj4gPj4+PiArCSAqIEluIGNhc2UgdGhl
IHN0YXRlX211dGV4IHdhcyB0YWtlbiBhbHJlYWR5IHdlIGRlZmVyIHRoZSBjbGVhbnVwIHdvcmsN
Cj4gPj4+PiArCSAqIHRvIHRoZSB1bmxvY2sgZmxvdyBvZiB0aGUgb3RoZXIgcnVubmluZyBjb250
ZXh0Lg0KPiA+Pj4+ICsJICovDQo+ID4+Pj4gKwlzcGluX2xvY2soJnFhdF92ZGV2LT5yZXNldF9s
b2NrKTsNCj4gPj4+PiArCXFhdF92ZGV2LT5kZWZlcnJlZF9yZXNldCA9IHRydWU7DQo+ID4+Pj4g
KwlpZiAoIW11dGV4X3RyeWxvY2soJnFhdF92ZGV2LT5zdGF0ZV9tdXRleCkpIHsNCj4gPj4+PiAr
CQlzcGluX3VubG9jaygmcWF0X3ZkZXYtPnJlc2V0X2xvY2spOw0KPiA+Pj4+ICsJCXJldHVybjsN
Cj4gPj4+PiArCX0NCj4gPj4+PiArCXNwaW5fdW5sb2NrKCZxYXRfdmRldi0+cmVzZXRfbG9jayk7
DQo+ID4+Pj4gKwlxYXRfdmZfc3RhdGVfbXV0ZXhfdW5sb2NrKHFhdF92ZGV2KTsNCj4gPj4+PiAr
fQ0KPiA+Pj4NCj4gPj4+IERvIHlvdSByZWFsbHkgbmVlZCB0aGlzPyBJIHRob3VnaHQgdGhpcyB1
Z2x5IHRoaW5nIHdhcyBnb2luZyB0byBiZSBhDQo+ID4+PiB1bmlxdWVseSBtbHg1IHRoaW5nLi4N
Cj4gPj4NCj4gPj4gSSB0aGluayB0aGF0J3Mgc3RpbGwgcmVxdWlyZWQgdG8gbWFrZSB0aGUgbWln
cmF0aW9uIHN0YXRlIHN5bmNocm9uaXplZA0KPiA+PiBpZiB0aGUgVkYgaXMgcmVzZXQgYnkgb3Ro
ZXIgVkZJTyBlbXVsYXRpb24gcGF0aHMuIElzIGl0IHRoZSBjYXNlPw0KPiA+PiBCVFcsIHRoaXMg
aW1wbGVtZW50YXRpb24gaXMgbm90IG9ubHkgaW4gbWx4NSBkcml2ZXIsIGJ1dCBhbHNvIGluIG90
aGVyDQo+ID4+IFZmaW8gcGNpIHZhcmlhbnQgZHJpdmVycyBzdWNoIGFzIGhpc2lsaWNvbiBhY2Mg
ZHJpdmVyIGFuZCBwZHMNCj4gPj4gZHJpdmVyLg0KPiA+DQo+ID4gSXQgaGFkIHRvIHNwZWNpZmlj
YWxseSBkbyB3aXRoIHRoZSBtbSBsb2NrIGludGVyYWN0aW9uIHRoYXQsIEkNCj4gPiB0aG91Z2h0
LCB3YXMgZ29pbmcgdG8gYmUgdW5pcXVlIHRvIHRoZSBtbHggZHJpdmVyLiBPdGhlcndpc2UgeW91
IGNvdWxkDQo+ID4ganVzdCBkaXJlY3RseSBob2xkIHRoZSBzdGF0ZV9tdXRleCBoZXJlLg0KPiA+
DQo+ID4gWWlzaGFpIGRvIHlvdSByZW1lbWJlciB0aGUgZXhhY3QgdHJhY2UgZm9yIHRoZSBtbWxv
Y2sgZW50YW5nbGVtZW50Pw0KPiA+DQo+IA0KPiBJIGZvdW5kIGluIG15IGluLWJveCAoZnJvbSBt
b3JlIHRoYW4gMi41IHllYXJzIGFnbykgdGhlIGJlbG93IFsxXQ0KPiBsb2NrZGVwIFdBUk5JTkcg
d2hlbiB0aGUgc3RhdGVfbXV0ZXggd2FzIHVzZWQgZGlyZWN0bHkuDQo+IA0KPiBPbmNlIHdlIG1v
dmVkIHRvIHRoZSAnZGVmZXJyZWRfcmVzZXQnIG1vZGUgaXQgc29sdmVkIHRoYXQuDQo+IA0KPiBb
MV0NCj4gWyAgKzEuMDYzODIyXSA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT0NCj4gWyAgKzAuMDAwNzMyXSBXQVJOSU5HOiBwb3NzaWJsZSBjaXJj
dWxhciBsb2NraW5nIGRlcGVuZGVuY3kgZGV0ZWN0ZWQNCj4gWyAgKzAuMDAwNzQ3XSA1LjE1LjAt
cmMzICMyMzYgTm90IHRhaW50ZWQNCj4gWyAgKzAuMDAwNTU2XSAtLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gWyAgKzAuMDAwNzE0XSBxZW11
LXN5c3RlbS14ODYvNzczMSBpcyB0cnlpbmcgdG8gYWNxdWlyZSBsb2NrOg0KPiBbICArMC4wMDA2
NTldIGZmZmY4ODgxMjZjNjRiNzggKCZ2ZGV2LT52bWFfbG9jayl7Ky4rLn0tezM6M30sIGF0Og0K
PiB2ZmlvX3BjaV9tbWFwX2ZhdWx0KzB4MzUvMHgxNDAgW3ZmaW9fcGNpX2NvcmVdDQo+IFsgICsw
LjAwMTEyN10NCj4gICAgICAgICAgICAgICAgYnV0IHRhc2sgaXMgYWxyZWFkeSBob2xkaW5nIGxv
Y2s6DQo+IFsgICswLjAwMDgwM10gZmZmZjg4ODEwNWY0YzVkOCAoJm1tLT5tbWFwX2xvY2sjMil7
KysrK30tezM6M30sIGF0Og0KPiB2YWRkcl9nZXRfcGZucysweDY0LzB4MjQwIFt2ZmlvX2lvbW11
X3R5cGUxXQ0KPiBbICArMC4wMDExMTldDQo+ICAgICAgICAgICAgICAgIHdoaWNoIGxvY2sgYWxy
ZWFkeSBkZXBlbmRzIG9uIHRoZSBuZXcgbG9jay4NCj4gDQo+IFsgICswLjAwMTA4Nl0NCj4gICAg
ICAgICAgICAgICAgdGhlIGV4aXN0aW5nIGRlcGVuZGVuY3kgY2hhaW4gKGluIHJldmVyc2Ugb3Jk
ZXIpIGlzOg0KPiBbICArMC4wMDA5MTBdDQo+ICAgICAgICAgICAgICAgIC0+ICMzICgmbW0tPm1t
YXBfbG9jayMyKXsrKysrfS17MzozfToNCj4gWyAgKzAuMDAwODQ0XSAgICAgICAgX19taWdodF9m
YXVsdCsweDU2LzB4ODANCj4gWyAgKzAuMDAwNTcyXSAgICAgICAgX2NvcHlfdG9fdXNlcisweDFl
LzB4ODANCj4gWyAgKzAuMDAwNTU2XSAgICAgICAgbWx4NXZmX3BjaV9taWdfcncuY29sZCsweGEx
LzB4MjRmIFttbHg1X3ZmaW9fcGNpXQ0KPiBbICArMC4wMDA3MzJdICAgICAgICB2ZnNfcmVhZCsw
eGE4LzB4MWMwDQo+IFsgICswLjAwMDU0N10gICAgICAgIF9feDY0X3N5c19wcmVhZDY0KzB4OGMv
MHhjMA0KPiBbICArMC4wMDA1ODBdICAgICAgICBkb19zeXNjYWxsXzY0KzB4M2QvMHg5MA0KPiBb
ICArMC4wMDA1NjZdICAgICAgICBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg0NC8w
eGFlDQo+IFsgICswLjAwMDY4Ml0NCj4gICAgICAgICAgICAgICAgLT4gIzIgKCZtdmRldi0+c3Rh
dGVfbXV0ZXgpeysuKy59LXszOjN9Og0KPiBbICArMC4wMDA4OTldICAgICAgICBfX211dGV4X2xv
Y2srMHg4MC8weDlkMA0KPiBbICArMC4wMDA1NjZdICAgICAgICBtbHg1dmZfcmVzZXRfZG9uZSsw
eDJjLzB4NDAgW21seDVfdmZpb19wY2ldDQo+IFsgICswLjAwMDY5N10gICAgICAgIHZmaW9fcGNp
X2NvcmVfaW9jdGwrMHg1ODUvMHgxMDIwIFt2ZmlvX3BjaV9jb3JlXQ0KPiBbICArMC4wMDA3MjFd
ICAgICAgICBfX3g2NF9zeXNfaW9jdGwrMHg0MzYvMHg5YTANCj4gWyAgKzAuMDAwNTg4XSAgICAg
ICAgZG9fc3lzY2FsbF82NCsweDNkLzB4OTANCj4gWyAgKzAuMDAwNTg0XSAgICAgICAgZW50cnlf
U1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NDQvMHhhZQ0KPiBbICArMC4wMDA2NzRdDQo+ICAg
ICAgICAgICAgICAgIC0+ICMxICgmdmRldi0+bWVtb3J5X2xvY2speysuKy59LXszOjN9Og0KPiBb
ICArMC4wMDA4NDNdICAgICAgICBkb3duX3dyaXRlKzB4MzgvMHg3MA0KPiBbICArMC4wMDA1NDRd
ICAgICAgICB2ZmlvX3BjaV96YXBfYW5kX2Rvd25fd3JpdGVfbWVtb3J5X2xvY2srMHgxYy8weDMw
DQo+IFt2ZmlvX3BjaV9jb3JlXQ0KPiBbICArMC4wMDM3MDVdICAgICAgICB2ZmlvX2Jhc2ljX2Nv
bmZpZ193cml0ZSsweDFlNy8weDI4MCBbdmZpb19wY2lfY29yZV0NCj4gWyAgKzAuMDAwNzQ0XSAg
ICAgICAgdmZpb19wY2lfY29uZmlnX3J3KzB4MWI3LzB4M2FmIFt2ZmlvX3BjaV9jb3JlXQ0KPiBb
ICArMC4wMDA3MTZdICAgICAgICB2ZnNfd3JpdGUrMHhlNi8weDM5MA0KPiBbICArMC4wMDA1Mzld
ICAgICAgICBfX3g2NF9zeXNfcHdyaXRlNjQrMHg4Yy8weGMwDQo+IFsgICswLjAwMDYwM10gICAg
ICAgIGRvX3N5c2NhbGxfNjQrMHgzZC8weDkwDQo+IFsgICswLjAwMDU3Ml0gICAgICAgIGVudHJ5
X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDQ0LzB4YWUNCj4gWyAgKzAuMDAwNjYxXQ0KPiAg
ICAgICAgICAgICAgICAtPiAjMCAoJnZkZXYtPnZtYV9sb2NrKXsrLisufS17MzozfToNCj4gWyAg
KzAuMDAwODI4XSAgICAgICAgX19sb2NrX2FjcXVpcmUrMHgxMjQ0LzB4MjI4MA0KPiBbICArMC4w
MDA1OTZdICAgICAgICBsb2NrX2FjcXVpcmUrMHhjMi8weDJjMA0KPiBbICArMC4wMDA1NTZdICAg
ICAgICBfX211dGV4X2xvY2srMHg4MC8weDlkMA0KPiBbICArMC4wMDA1ODBdICAgICAgICB2Zmlv
X3BjaV9tbWFwX2ZhdWx0KzB4MzUvMHgxNDAgW3ZmaW9fcGNpX2NvcmVdDQo+IFsgICswLjAwMDcw
OV0gICAgICAgIF9fZG9fZmF1bHQrMHgzMi8weGEwDQo+IFsgICswLjAwMDU1Nl0gICAgICAgIF9f
aGFuZGxlX21tX2ZhdWx0KzB4YmU4LzB4MTQ1MA0KPiBbICArMC4wMDA2MDZdICAgICAgICBoYW5k
bGVfbW1fZmF1bHQrMHg2Yy8weDE0MA0KPiBbICArMC4wMDA2MjRdICAgICAgICBmaXh1cF91c2Vy
X2ZhdWx0KzB4NmIvMHgxMDANCj4gWyAgKzAuMDAwNjAwXSAgICAgICAgdmFkZHJfZ2V0X3BmbnMr
MHgxMDgvMHgyNDAgW3ZmaW9faW9tbXVfdHlwZTFdDQo+IFsgICswLjAwMDcyNl0gICAgICAgIHZm
aW9fcGluX3BhZ2VzX3JlbW90ZSsweDMyNi8weDQ2MCBbdmZpb19pb21tdV90eXBlMV0NCj4gWyAg
KzAuMDAwNzM2XSAgICAgICAgdmZpb19pb21tdV90eXBlMV9pb2N0bCsweDQzYi8weDE1YTAgW3Zm
aW9faW9tbXVfdHlwZTFdDQo+IFsgICswLjAwMDc1Ml0gICAgICAgIF9feDY0X3N5c19pb2N0bCsw
eDQzNi8weDlhMA0KPiBbICArMC4wMDA1ODhdICAgICAgICBkb19zeXNjYWxsXzY0KzB4M2QvMHg5
MA0KPiBbICArMC4wMDA1NzFdICAgICAgICBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUr
MHg0NC8weGFlDQo+IFsgICswLjAwMDY3N10NCj4gICAgICAgICAgICAgICAgb3RoZXIgaW5mbyB0
aGF0IG1pZ2h0IGhlbHAgdXMgZGVidWcgdGhpczoNCj4gDQo+IFsgICswLjAwMTA3M10gQ2hhaW4g
ZXhpc3RzIG9mOg0KPiAgICAgICAgICAgICAgICAgICZ2ZGV2LT52bWFfbG9jayAtLT4gJm12ZGV2
LT5zdGF0ZV9tdXRleCAtLT4NCj4gJm1tLT5tbWFwX2xvY2sjMg0KPiANCj4gWyAgKzAuMDAxMjg1
XSAgUG9zc2libGUgdW5zYWZlIGxvY2tpbmcgc2NlbmFyaW86DQo+IA0KPiBbICArMC4wMDA4MDhd
ICAgICAgICBDUFUwICAgICAgICAgICAgICAgICAgICBDUFUxDQo+IFsgICswLjAwMDU5OV0gICAg
ICAgIC0tLS0gICAgICAgICAgICAgICAgICAgIC0tLS0NCj4gWyAgKzAuMDAwNTkzXSAgIGxvY2so
Jm1tLT5tbWFwX2xvY2sjMik7DQo+IFsgICswLjAwMDUzMF0gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGxvY2soJm12ZGV2LT5zdGF0ZV9tdXRleCk7DQo+IFsgICswLjAwMDcyNV0gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGxvY2soJm1tLT5tbWFwX2xvY2sjMik7DQo+IFsg
ICswLjAwMDcxMl0gICBsb2NrKCZ2ZGV2LT52bWFfbG9jayk7DQo+IFsgICswLjAwMDUzMl0NCj4g
ICAgICAgICAgICAgICAgICoqKiBERUFETE9DSyAqKioNCg0KVGhhbmtzIGZvciB0aGlzIGluZm9y
bWF0aW9uLCBidXQgdGhpcyBmbG93IGlzIG5vdCBjbGVhciB0byBtZSB3aHkgaXQgDQpjYXVzZSBk
ZWFkbG9jay4gRnJvbSB0aGlzIGZsb3csIENQVTAgaXMgbm90IHdhaXRpbmcgZm9yIGFueSByZXNv
dXJjZQ0KaGVsZCBieSBDUFUxLCBzbyBhZnRlciBDUFUwIHJlbGVhc2VzIG1tYXBfbG9jaywgQ1BV
MSBjYW4gY29udGludWUNCnRvIHJ1bi4gQW0gSSBtaXNzaW5nIHNvbWV0aGluZz8gDQpNZWFud2hp
bGUsIGl0IHNlZW1zIHRoZSB0cmFjZSBhYm92ZSBpcyB0cmlnZ2VyZWQgd2l0aCBtaWdyYXRpb24N
CnByb3RvY29sIHYxLCB0aGUgY29udGV4dCBvZiBDUFUxIGxpc3RlZCBhbHNvIHNlZW1zIHByb3Rv
Y29sIHYxDQpzcGVjaWZpYy4gSXMgaXQgdGhlIGNhc2U/DQpUaGFua3MsDQpYaW4NCg0KPiANCj4g
WyAgKzAuMDAwOTIyXSAyIGxvY2tzIGhlbGQgYnkgcWVtdS1zeXN0ZW0teDg2Lzc3MzE6DQo+IFsg
ICswLjAwMDU5N10gICMwOiBmZmZmODg4MTBjOWJlYzg4ICgmaW9tbXUtPmxvY2sjMil7Ky4rLn0t
ezM6M30sIGF0Og0KPiB2ZmlvX2lvbW11X3R5cGUxX2lvY3RsKzB4MTg5LzB4MTVhMCBbdmZpb19p
b21tdV90eXBlMV0NCj4gWyAgKzAuMDAxMTc3XSAgIzE6IGZmZmY4ODgxMDVmNGM1ZDggKCZtbS0+
bW1hcF9sb2NrIzIpeysrKyt9LXszOjN9LCBhdDoNCj4gdmFkZHJfZ2V0X3BmbnMrMHg2NC8weDI0
MCBbdmZpb19pb21tdV90eXBlMV0NCj4gWyAgKzAuMDAxMTUzXQ0KPiAgICAgICAgICAgICAgICBz
dGFjayBiYWNrdHJhY2U6DQo+IFsgICswLjAwMDY4OV0gQ1BVOiAxIFBJRDogNzczMSBDb21tOiBx
ZW11LXN5c3RlbS14ODYgTm90IHRhaW50ZWQNCj4gNS4xNS4wLXJjMyAjMjM2DQo+IFsgICswLjAw
MDkzMl0gSGFyZHdhcmUgbmFtZTogUUVNVSBTdGFuZGFyZCBQQyAoUTM1ICsgSUNIOSwgMjAwOSks
IEJJT1MNCj4gcmVsLTEuMTMuMC0wLWdmMjFiNWE0YWViMDItcHJlYnVpbHQucWVtdS5vcmcgMDQv
MDEvMjAxNA0KPiBbICArMC4wMDExOTJdIENhbGwgVHJhY2U6DQo+IFsgICswLjAwMDQ1NF0gIGR1
bXBfc3RhY2tfbHZsKzB4NDUvMHg1OQ0KPiBbICArMC4wMDA1MjddICBjaGVja19ub25jaXJjdWxh
cisweGYyLzB4MTEwDQo+IFsgICswLjAwMDU1N10gIF9fbG9ja19hY3F1aXJlKzB4MTI0NC8weDIy
ODANCj4gWyAgKzAuMDAyNDYyXSAgbG9ja19hY3F1aXJlKzB4YzIvMHgyYzANCj4gWyAgKzAuMDAw
NTM0XSAgPyB2ZmlvX3BjaV9tbWFwX2ZhdWx0KzB4MzUvMHgxNDAgW3ZmaW9fcGNpX2NvcmVdDQo+
IFsgICswLjAwMDY4NF0gID8gbG9ja19pc19oZWxkX3R5cGUrMHg5OC8weDExMA0KPiBbICArMC4w
MDA1NjVdICBfX211dGV4X2xvY2srMHg4MC8weDlkMA0KPiBbICArMC4wMDA1NDJdICA/IHZmaW9f
cGNpX21tYXBfZmF1bHQrMHgzNS8weDE0MCBbdmZpb19wY2lfY29yZV0NCj4gWyAgKzAuMDAwNjc2
XSAgPyB2ZmlvX3BjaV9tbWFwX2ZhdWx0KzB4MzUvMHgxNDAgW3ZmaW9fcGNpX2NvcmVdDQo+IFsg
ICswLjAwMDY4MV0gID8gbWFya19oZWxkX2xvY2tzKzB4NDkvMHg3MA0KPiBbICArMC4wMDA1NTFd
ICA/IGxvY2tfaXNfaGVsZF90eXBlKzB4OTgvMHgxMTANCj4gWyAgKzAuMDAwNTc1XSAgdmZpb19w
Y2lfbW1hcF9mYXVsdCsweDM1LzB4MTQwIFt2ZmlvX3BjaV9jb3JlXQ0KPiBbICArMC4wMDA2Nzld
ICBfX2RvX2ZhdWx0KzB4MzIvMHhhMA0KPiBbICArMC4wMDA3MDBdICBfX2hhbmRsZV9tbV9mYXVs
dCsweGJlOC8weDE0NTANCj4gWyAgKzAuMDAwNTcxXSAgaGFuZGxlX21tX2ZhdWx0KzB4NmMvMHgx
NDANCj4gWyAgKzAuMDAwNTY0XSAgZml4dXBfdXNlcl9mYXVsdCsweDZiLzB4MTAwDQo+IFsgICsw
LjAwMDU1Nl0gIHZhZGRyX2dldF9wZm5zKzB4MTA4LzB4MjQwIFt2ZmlvX2lvbW11X3R5cGUxXQ0K
PiBbICArMC4wMDA2NjZdICA/IGxvY2tfaXNfaGVsZF90eXBlKzB4OTgvMHgxMTANCj4gWyAgKzAu
MDAwNTcyXSAgdmZpb19waW5fcGFnZXNfcmVtb3RlKzB4MzI2LzB4NDYwIFt2ZmlvX2lvbW11X3R5
cGUxXQ0KPiBbICArMC4wMDA3MTBdICB2ZmlvX2lvbW11X3R5cGUxX2lvY3RsKzB4NDNiLzB4MTVh
MCBbdmZpb19pb21tdV90eXBlMV0NCj4gWyAgKzAuMDAxMDUwXSAgPyBmaW5kX2hlbGRfbG9jaysw
eDJiLzB4ODANCj4gWyAgKzAuMDAwNTYxXSAgPyBsb2NrX3JlbGVhc2UrMHhjMi8weDJhMA0KPiBb
ICArMC4wMDA1MzddICA/IF9fZmdldF9maWxlcysweGRjLzB4MWQwDQo+IFsgICswLjAwMDU0MV0g
IF9feDY0X3N5c19pb2N0bCsweDQzNi8weDlhMA0KPiBbICArMC4wMDA1NTZdICA/IGxvY2tkZXBf
aGFyZGlycXNfb25fcHJlcGFyZSsweGQ0LzB4MTcwDQo+IFsgICswLjAwMDY0MV0gIGRvX3N5c2Nh
bGxfNjQrMHgzZC8weDkwDQo+IFsgICswLjAwMDUyOV0gIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJf
aHdmcmFtZSsweDQ0LzB4YWUNCj4gWyAgKzAuMDAwNjcwXSBSSVA6IDAwMzM6MHg3ZjU0MjU1YmI0
NWINCj4gWyAgKzAuMDAwNTQxXSBDb2RlOiAwZiAxZSBmYSA0OCA4YiAwNSAyZCBhYSAyYyAwMCA2
NCBjNyAwMCAyNiAwMCAwMCAwMA0KPiA0OCBjNyBjMCBmZiBmZiBmZiBmZiBjMyA2NiAwZiAxZiA0
NCAwMCAwMCBmMyAwZiAxZSBmYSBiOCAxMCAwMCAwMCAwMCAwZg0KPiAwNSA8NDg+IDNkIDAxIGYw
IGZmIGZmIDczIDAxIGMzIDQ4IDhiIDBkIGZkIGE5IDJjIDAwIGY3IGQ4IDY0IDg5IDAxIDQ4DQo+
IFsgICswLjAwMTg0M10gUlNQOiAwMDJiOjAwMDA3ZjU0MTVjYTNkMzggRUZMQUdTOiAwMDAwMDIw
NiBPUklHX1JBWDoNCj4gMDAwMDAwMDAwMDAwMDAxMA0KPiBbICArMC4wMDA5MjldIFJBWDogZmZm
ZmZmZmZmZmZmZmZkYSBSQlg6IDAwMDAwMDAwMDAwMDAwMDAgUkNYOg0KPiAwMDAwN2Y1NDI1NWJi
NDViDQo+IFsgICswLjAwMDc4MV0gUkRYOiAwMDAwN2Y1NDE1Y2EzZDcwIFJTSTogMDAwMDAwMDAw
MDAwM2I3MSBSREk6DQo+IDAwMDAwMDAwMDAwMDAwMTINCj4gWyAgKzAuMDAwNzc1XSBSQlA6IDAw
MDA3ZjU0MTVjYTNkYTAgUjA4OiAwMDAwMDAwMDAwMDAwMDAwIFIwOToNCj4gMDAwMDAwMDAwMDAw
MDAwMA0KPiBbICArMC4wMDA3NzddIFIxMDogMDAwMDAwMDBmZTAwMjAwMCBSMTE6IDAwMDAwMDAw
MDAwMDAyMDYgUjEyOg0KPiAwMDAwMDAwMDAwMDAwMDA0DQo+IFsgICswLjAwMDc3NV0gUjEzOiAw
MDAwMDAwMDAwMDAwMDAwIFIxNDogMDAwMDAwMDBmZTAwMDAwMCBSMTU6DQo+IDAwMDA3ZjU0MTVj
YTQ3YzANCj4gDQo+IFlpc2hhaQ0KDQoNCg0KDQo=

