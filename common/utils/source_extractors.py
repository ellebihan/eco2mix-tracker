from abc import ABC, abstractmethod
import datetime
import json
import pandas as pd
import requests
from pathlib import Path
from datetime import datetime

class SourceExtractor(ABC):
    """Abstract class defining a datasource extractor.
    Only the 'extract' method is mandatory, which is responsible
    for pulling the data and storing it in a local file.
    """
    @abstractmethod
    def download(self, domain: str, source):
        pass

class MetadonneesApiExtractor(SourceExtractor):
    """Extract data from Metadonnees API"""
    def download(self, domain, source):
        headers = source.get("headers", {})
        params = source.get("params", {})
        # response_path dépend de la structure du json
        response_path = source.get("response_path", 0)

        # Make request to API
        response = requests.get(source['url'], params=params, headers=headers)
        response.raise_for_status()

        # Create data directory if it doesn't exist
        data_dir = Path(f"data/imports/{domain}")
        data_dir.mkdir(parents=True, exist_ok=True)

        # Generate filename from source name
        # today = datetime.now().strftime("%Y-%m-%d")
        filename = f"{source['name']}.json"
        filepath = data_dir / filename
        
        # Display data
        data = response.json()
        # Extraire les records
        for key in response_path.split("."):
            data = data[key]
            print(data)
        # Extraire uniquement les champs "fields"
        fields_list = data
        # fields_list = [r["fields"] for r in records if "fields" in r]
        # print(fields_list)
        '''
        display = response.json()[response_path]
        print(display)

        if isinstance(data, list):
            data = response.json[0]["records"]
        else:
            data = response.json()["records"]
        '''
        
        # Write response content to file
        with open(filepath, 'w') as f:
            json.dump(fields_list, f, ensure_ascii=False, indent=2)
            # f.write(fields_list)
        return str(filepath)