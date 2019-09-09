# polyswarm-phantom

* Supported Actions:

   * detonate url - Load a URL to Polyswarm and retrieve analysis results
   * detonate file - Upload a file to Polyswarm and retrieve analysis results
   * get report - Lookup results from UUID
   * get file - Downloads a file from Polyswarm, and adds it to the vault
   * ip reputation - Queries Polyswarm for IP reputation info
   * domain reputation - Queries Polyswarm for Domain reputation info
   * url reputation - Queries Polyswarm for url reputation info
   * file reputation - Queries Polyswarm for file reputation info
   * test connectivity - Validate the asset configuration for connectivity using supplied configuration

* Repo Structure
```
.
├── app # where the Phantom APP lives
│   ├── compile.sh # bash script - compile and install the APP
│   ├── exclude_files.txt
│   ├── __init__.py
│   ├── polyswarm_connector.py # main APP code
│   ├── polyswarm_consts.py # const
│   ├── polyswarm_dark.png
│   ├── polyswarm.json # actions configuration file
│   ├── polyswarm.png
│   └── readme.html
├── config_template # template for remote node configuration
│   └── config
├── deploy # deploy APP to external Phantom node
│   ├── deploy_app.sh  # upload APP, compile and install
│   ├── deploy_config.sh # upload remote configuration for install
│   └── run_remote_unittest.sh # upload APP and run all test
├── playbooks # working starting examples
│   ├── Polyswarm_File_Full_Workflow_Playbook.tgz
│   └── Polyswarm_URL_Full_Workflow_Playbook.tgz
├── README.md
├── release # last APP release
│   └── polyswarm-phantom-v1.0.tgz
└── test # unit testing
    ├── json # testing File / URL / Test Connectivity setup files
    │   ├── detonate_file_exists.json
    │   ├── detonate_file_not_found.json
    │   ├── detonate_url_benign.json
    │   ├── detonate_url_malicious.json
    │   ├── domain_reputation_benign.json
    │   ├── domain_reputation_malicious.json
    │   ├── file_reputation_FileDoesNotExist.json
    │   ├── file_reputation_malicious.json
    │   ├── get_file_ErrorHash.json
    │   ├── get_file_exists.json
    │   ├── get_file_FileDoesNotExist.json
    │   ├── get_report_EICAR.json
    │   ├── ip_reputation_benign.json
    │   ├── ip_reputation_malicious.json
    │   ├── test_connectivity.json
    │   ├── url_reputation_benign.json
    │   └── url_reputation_malicious.json
    └── run_test.sh # Test individual unit test
                    # or run all test inside json/ folder
                    # See header for usage
```

## How to:

### Install from Phantom Web Interface:

1. Go to `APPs` -> `INSTALL APP`
2. Select tarball app from `release/` directory for install

### Compile and Install from Repository to remote node:

1. Run `deploy_app.sh` to upload this repo directory, compile it and install the
APP and make it ready to use from from Phantom Web Interface.

```
(master) gentoo deploy $ bash deploy.sh
[*] Deploying Phantom APP to node: 192.168.1.45
    [+] tar app...
    [+] cleaning up old files...
    [+] uploading app...
Unauthorized access prohibited.
 ____ ____ ____ ____ ____ ____ ____ ____ ____ ____ ____ ____ ____ ____
||s |||p |||l |||u |||n |||k |||> |||P |||h |||a |||n |||t |||o |||m ||
||__|||__|||__|||__|||__|||__|||__|||__|||__|||__|||__|||__|||__|||__||
|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
polyswarm-phantom.tar.gz                                                                                                                    100%  194KB  69.6MB/s   00:00
    [+] untar app...
    [+] compile and install app...
Unauthorized access prohibited.
 ____ ____ ____ ____ ____ ____ ____ ____ ____ ____ ____ ____ ____ ____
||s |||p |||l |||u |||n |||k |||> |||P |||h |||a |||n |||t |||o |||m ||
||__|||__|||__|||__|||__|||__|||__|||__|||__|||__|||__|||__|||__|||__||
|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
cd'ing into ./
Compiling: ./polyswarm_consts.py
Compiling: ./polyswarm_connector.py
Compiling: ./__init__.py
Validating App Json
  Working on: ./polyswarm.json
    Looks like an app json
  Processing App Json
  Processing actions
    test connectivity
      No further processing coded for this action
    file reputation
      Done
    url reputation
      Done
    domain reputation
      Done
    ip reputation
      Done
    get file
      Done
    get report
      Done
    detonate file
      Done
    detonate url
      Done
Installing app...
  Creating tarball...
  ../app.tgz
  Calling installer...
  Success
Done
Connection to 192.168.1.45 closed.
[*] Enjoy. :)
```
