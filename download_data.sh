#!/bin/bash

function download() {
    url=$1
    dest=$2

    response=$(curl -X GET ${url} -o -)
    format=$(echo ${response} | jq -r .format)
    if [ "${format}" = "base64" ] ; then
        echo ${response} | jq -j .content | base64 -d > $dest
    elif [ "${format}" = "text" ] ; then
        echo ${response} | jq -j .content > $dest
    else
        echo "Format ${format} of file ${dest} not supported"
        echo ${response} | jq -j .content > $dest
    fi
}

notebook_created="no"

function get_notebook() {
    ## Creates a new notebook if needed. Sets flag to delete if
    ## notebook was re-created.
    apiurl=$1
    sessionid=$2
    serviceid=$3
    svcinfo=`curl --silent -X GET "${apiurl}/${serviceid}" -H  "accept: application/json"`
    if [ $(echo ${svcinfo} | jq -j .sessionId) = "${sessionid}" ] ; then
        return ## NOTEBOOK_URL unchanged.
    fi
    
    svcinfo=`curl --silent -X POST "${apiurl}" -H  "accept: application/json" \
                  -H  "Content-Type: application/json" -d "{\"sessionId\":\"${sessionid}\"}"`
    notebook_created="yes"
    
    svcurl=`echo ${svcinfo} | jq -j .serviceURL`
    if [ "${svcurl}" = "null" ] ; then
        echo "Session ${sessionid} no longer exists. Cannot download data."
        exit 1
    fi

    SERVICE_ID=`echo ${svcinfo} | jq -j .id`
    echo "Wait for service ${SERVICE_ID} to be re-created at ${svcurl}."
    while ! curl --silent -IL -X GET ${svcurl} | grep "200 OK" ; do
        sleep 5
    done
    NOTEBOOK_URL=${svcurl}
}

function delete_notebook() {
    apiurl=$1
    if [ "${notebook_created}" = "yes" ] ; then
        curl -X DELETE "${apiurl}/${SERVICE_ID}" -H  "accept: */*"
    fi
}

function download_working_dir_data() {
    if [ ! -e download_filelist.dat ] ; then
        echo "Nothing to download from working dir."
        return
    fi
    apiurl=$1
    for file in `cat download_filelist.dat` ; do
        download ${apiurl}/${file} ${HOME}/${file}
    done
}

conda install -y -c conda-forge curl jq || exit 1


# =======================================================
# Everything below here is generated by the snapshot job:
# =======================================================
NOTEBOOK_URL=https://swirrl.climate4impact.eu/swirrl/jupyter/3036003f-4a15-4880-b449-c3b35de00ac7
SERVICE_ID=3036003f-4a15-4880-b449-c3b35de00ac7
get_notebook http://swirrl-api/swirrl-api/v1.0/notebook 1dd85069-6cc8-46ab-bc1f-f02c331c0c4f 3036003f-4a15-4880-b449-c3b35de00ac7
mkdir -p ~/data/staginghistory/stage.00001
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20720101-20721231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20720101-20721231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20750101-20751231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20750101-20751231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20910101-20911231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20910101-20911231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20920101-20921231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20920101-20921231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20940101-20941231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20940101-20941231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20790101-20791231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20790101-20791231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20400101-20401231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20400101-20401231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20490101-20491231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20490101-20491231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20980101-20981231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20980101-20981231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20830101-20831231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20830101-20831231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20900101-20901231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20900101-20901231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20500101-20501231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20500101-20501231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20590101-20591231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20590101-20591231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20310101-20311231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20310101-20311231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20710101-20711231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20710101-20711231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20530101-20531231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20530101-20531231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20850101-20851231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20850101-20851231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20320101-20321231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20320101-20321231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20350101-20351231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20350101-20351231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20520101-20521231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20520101-20521231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20610101-20611231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20610101-20611231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20770101-20771231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20770101-20771231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20870101-20871231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20870101-20871231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20370101-20371231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20370101-20371231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20180101-20181231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20180101-20181231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20690101-20691231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20690101-20691231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20380101-20381231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20380101-20381231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20210101-20211231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20210101-20211231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20960101-20961231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20960101-20961231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20290101-20291231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20290101-20291231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20860101-20861231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20860101-20861231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20730101-20731231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20730101-20731231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20800101-20801231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20800101-20801231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/swirrl_fileinfo.json ~/data/staginghistory/stage.00001/swirrl_fileinfo.json
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20810101-20811231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20810101-20811231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20890101-20891231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20890101-20891231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20840101-20841231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20840101-20841231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20390101-20391231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20390101-20391231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20260101-20261231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20260101-20261231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20220101-20221231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20220101-20221231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20780101-20781231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20780101-20781231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20580101-20581231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20580101-20581231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20550101-20551231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20550101-20551231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20540101-20541231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20540101-20541231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20440101-20441231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20440101-20441231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20230101-20231231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20230101-20231231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20630101-20631231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20630101-20631231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20510101-20511231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20510101-20511231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20650101-20651231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20650101-20651231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20970101-20971231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20970101-20971231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20640101-20641231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20640101-20641231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20480101-20481231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20480101-20481231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20470101-20471231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20470101-20471231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20300101-20301231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20300101-20301231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20270101-20271231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20270101-20271231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20170101-20171231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20170101-20171231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20460101-20461231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20460101-20461231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20560101-20561231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20560101-20561231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20250101-20251231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20250101-20251231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20160101-20161231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20160101-20161231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20360101-20361231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20360101-20361231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20600101-20601231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20600101-20601231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20200101-20201231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20200101-20201231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20570101-20571231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20570101-20571231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_21000101-21001231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_21000101-21001231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20930101-20931231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20930101-20931231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20700101-20701231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20700101-20701231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20620101-20621231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20620101-20621231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20760101-20761231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20760101-20761231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20660101-20661231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20660101-20661231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20740101-20741231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20740101-20741231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20340101-20341231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20340101-20341231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20150101-20151231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20150101-20151231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20680101-20681231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20680101-20681231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20420101-20421231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20420101-20421231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20990101-20991231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20990101-20991231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20820101-20821231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20820101-20821231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20430101-20431231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20430101-20431231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20880101-20881231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20880101-20881231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20670101-20671231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20670101-20671231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20450101-20451231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20450101-20451231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20190101-20191231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20190101-20191231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20410101-20411231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20410101-20411231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20950101-20951231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20950101-20951231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20280101-20281231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20280101-20281231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20240101-20241231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20240101-20241231.nc
download ${NOTEBOOK_URL}/api/contents/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20330101-20331231.nc ~/data/staginghistory/stage.00001/tasmax_day_EC-Earth3_ssp585_r1i1p1f1_gr_20330101-20331231.nc
ln -s ~/data/staginghistory/stage.00001 ~/data/latest
download_working_dir_data ${NOTEBOOK_URL}/api/contents
delete_notebook http://swirrl-api/swirrl-api/v1.0/notebook
